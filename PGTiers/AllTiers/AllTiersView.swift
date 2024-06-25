//
//  AllTiersView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI
import RealmSwift

struct AllTiersView: View {
    
    var completion: () -> ()
    @State var list: [TierList] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                if list.isEmpty {
                    VStack(spacing: 60) {
                        Text("Oops, it looks like you don't have any Tier Lists yet.")
                            .font(.system(size: 25))
                        
                        Image(systemName: "squares.leading.rectangle")
                            .font(.system(size: 150))
                        
                        Text("You can create a new one on the main screen.")
                            .font(.system(size: 25))
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray.opacity(0.5))
                    .padding(.horizontal, 30)
                }
                
                VStack {
                    HStack {
                        Text("Tier List")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    
                    
                    ScrollView {
                        VStack {
                            ForEach(list, id: \.id) { list in
                                
                                NavigationLink {
                                    TierListMakerView(realmTierList: list) {
                                        print("APPEAR")
                                        self.list = Array(StorageManager.shared.tierLists)
                                        completion()
                                    }
                                        .onAppear {
                                            completion()
                                        }
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    NewTierCell(dataImage: list.tiers.first?.sTier.first, name: list.tierListName)
                                        .padding(.vertical, 2)
                                }

                            }
                        }
                    }
                    .padding(.top, -20)
                    .hideScrollIndicator()
                }
            }
        }
        .phoneOnlyStackNavigationView()
        .onAppear {
            list = Array(StorageManager.shared.tierLists)
        }
    }
}

#Preview {
    AllTiersView(){}
}
