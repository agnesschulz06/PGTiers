//
//  CustomGradesView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI
import RealmSwift

struct CustomGradesView: View {
    
    var completion: () -> ()
    @State var grades: [CustomGradeList] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackView()
                
                if grades.isEmpty {
                    VStack(spacing: 60) {
                        Text("Oops, it looks like you don't have any Custom Grade Lists yet.")
                            .font(.system(size: 25))
                        
                        Image(systemName: "plus.square")
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
                        Text("Custom Grades")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)
                            .padding(.leading)
                        
                        Spacer()
                    }
                    
                    
                    
                    ScrollView {
                        VStack {
                            ForEach(grades, id: \.id) { list in
                                
                                NavigationLink {
                                    CustomGradeMaker(realmGrade: list) {
                                        self.grades = Array(StorageManager.shared.customGradeLists)
                                        completion()
                                    }
                                        .onAppear {
                                            completion()
                                        }
                                        .navigationBarBackButtonHidden()
                                        .navigationBarHidden(true)
                                        .toolbar(.hidden, for: .tabBar)
                                } label: {
                                    NewTierCell(dataImage: list.grades.first?.image, name: list.gradeCategoryName)
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
            grades = Array(StorageManager.shared.customGradeLists)
        }
    }
}

#Preview {
    CustomGradesView(){}
}
