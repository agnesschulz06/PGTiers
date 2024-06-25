//
//  HomeView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import SwiftUI

struct HomeView: View {
    
    init() {
           UITabBar.appearance().isHidden = true
       }
    
    @State private var isTierShown = false
    @State private var isGradeShown = false
    @State private var isCustomShown = false
    @State private var isSettingsShown = false

    
    var body: some View {
            ZStack {
                BackView()
                
                ScrollView {
                    VStack {
                        MainAnimationView()
                        
                            VStack {
                                Text("Templates:")
                                    .frame(width: screenSize().width - 20, alignment: .leading)
                                    .font(.system(size: 22, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                    .padding(.leading, 40)
                                
                                HStack(spacing: 20) {
                                    Button {
                                        isTierShown.toggle()
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .fill(LinearGradient(colors: [.lightBlue, . lightPink], startPoint: .topLeading, endPoint: .bottomTrailing))
                                                .frame(height: 120)
                                                .cornerRadius(12)
                                            
                                            VStack(spacing: 10) {
                                                Text("Tier List")
                                                
                                                Image(systemName: "squares.leading.rectangle")
                                            }
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                        }
                                    }
                                    
                                    Button {
                                        isGradeShown.toggle()
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .fill(LinearGradient(colors: [.lightBlue, .lightPink], startPoint: .bottomTrailing, endPoint: .topLeading))
                                                .frame(height: 120)
                                                .cornerRadius(12)
                                            
                                            VStack(spacing: 10) {
                                                Text("Grade List")
                                                
                                                Image(systemName: "line.horizontal.3")
                                            }
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                        }
                                    }
                                }
                                .padding(.horizontal, 30)
                                
                                Text("Custom:")
                                    .frame(width: screenSize().width - 20, alignment: .leading)
                                    .font(.system(size: 22, weight: .bold, design: .monospaced))
                                    .foregroundColor(.white)
                                    .padding(.leading, 40)
                                
                                HStack {
                                    Button {
                                        isCustomShown.toggle()
                                    } label: {
                                        ZStack {
                                            Rectangle()
                                                .fill(LinearGradient(colors: [.lightPink, .lightBlue], startPoint: .topTrailing, endPoint: .bottomLeading))
                                                .frame(width: screenSize().width / 2.4, height: 120)
                                                .cornerRadius(12)
                                            
                                            VStack(spacing: 10) {
                                                Text("Make own")
                                                
                                                Image(systemName: "plus.square")
                                            }
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                            
                                        }
                                      
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.horizontal, 30)
                                
//                                VStack {
//
//                                }.frame(height: 50)
                            }
                        
                        .padding(.top, -20)
                        
                        
                        Spacer()
                    }
                }
                .hideScrollIndicator()
            }
            .modifier(HideTabBar())
            .overlay {
                VStack {
                    
                    HStack {
                      //  Spacer()
                        
                        Button {
                            isSettingsShown.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                        .frame(width: screenSize().width - 40, alignment: .trailing)
                        .foregroundColor(.white)
                        .padding(.top)
                    }
                    
                    Spacer()
                }
            }
        
        .fullScreenCover(isPresented: $isTierShown) {
            TierListMakerView(){}
        }
        .fullScreenCover(isPresented: $isGradeShown) {
            GradeListMakerView(){}
        }
        .fullScreenCover(isPresented: $isCustomShown) {
            CustomGradeMaker(){}
        }
        .fullScreenCover(isPresented: $isSettingsShown) {
            SettingsView()
        }
    }
}

#Preview {
    HomeView()
}
