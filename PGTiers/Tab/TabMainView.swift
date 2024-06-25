//
//  TabMainView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import SwiftUI

struct TabMainView: View {
    
    init() {
           UITabBar.appearance().isHidden = true
       }
    
    @State private var isTabBarShown = true
    @State private var actibeTab: Tab = .home
    
    var body: some View {
        NavigationView {
            ZStack {
                BackView()
                
                TabView(selection: $actibeTab) {
                    HomeView()
                        .navigationBarHidden(true)
                        .toolbar(.hidden, for: .tabBar)
                        .tag(Tab.home)
                        .modifier(HideTabBar())
                    
                    AllTiersView() {
                        isTabBarShown.toggle()
                    }
                    .navigationBarHidden(true)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.stat)
                    .modifier(HideTabBar())
                    
                    AllGradesView() {
                        isTabBarShown.toggle()
                    }
                    .navigationBarHidden(true)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.percent)
                    .modifier(HideTabBar())
                    
                    CustomGradesView() {
                        isTabBarShown.toggle()
                    }
                    .navigationBarHidden(true)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(Tab.settings)
                    .modifier(HideTabBar())

                }
                
                
            }
            .overlay {
                if isTabBarShown {
                    VStack {
                        Spacer()
                        
                        
                        TabBarView(tab: $actibeTab)
                            .toolbar(.hidden, for: .tabBar)
                            .padding(.horizontal)
                            .ignoresSafeArea()
                    }
                }
                
            }
        }
        .phoneOnlyStackNavigationView()
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    TabMainView()
        .preferredColorScheme(.light)
}


struct TabBarView: View {
    
    @Binding var tab: Tab
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.darkBlue)
                .shadow(color: .lightBlue.opacity(0.4), radius: 20, x: 0, y: 20)
            
            TabsLayoutView(selectedTab: $tab)
                .toolbar(.hidden, for: .tabBar)
                .navigationBarHidden(true)
                .modifier(HideTabBar())
        }
        .frame(height: 70, alignment: .center)
        .padding(.bottom, 10)
    }
}

fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .toolbar(.hidden, for: .tabBar)
                    .frame(width: 65, height: 65, alignment: .center)
                    .toolbar(.hidden, for: .tabBar)
                    .navigationBarHidden(true)
                    .modifier(HideTabBar())
                Spacer(minLength: 0)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .modifier(HideTabBar())
    }
    
    
    
    private struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        Circle()
                            .foregroundColor(.darkBlue)
                            .shadow(radius: 10)
                            .background {
                                Circle()
                                    .stroke(lineWidth: 15)
                                    .foregroundColor(.lightPink.opacity(0.7))
                                
                            }
                            .offset(y: -25)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.spring(), value: selectedTab)
                    }
                    
                    Image(systemName: tab.icon)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                        .foregroundColor(isSelected ? .init(white: 0.9) : .gray)
                        .scaleEffect(isSelected ? 1 : 0.8)
                        .offset(y: isSelected ? -25 : 0)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}


enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, stat, percent, settings
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .stat:
            return "squares.leading.rectangle"
        case .percent:
            return "line.horizontal.3"
        case .settings:
            return "plus.square"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return .indigo
        case .stat:
            return .pink
        case .percent:
            return .orange
        case .settings:
            return .teal
        }
    }
}
