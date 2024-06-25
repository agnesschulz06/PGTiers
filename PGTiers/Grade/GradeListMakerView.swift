//
//  GradeListMakerView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI

struct GradeListMakerView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = GradeListMakerViewModel()
    @State private var nameList = ""

    var grades = ["10", "9", "8", "7", "6", "5", "4", "3", "2", "1"]
    var realmGrade: GradeList?
    var completion: () -> ()
    
    @State var imageToShare: UIImage?
    @State var isSnapshotShown = false
    
    
    var body: some View {
        ZStack {
            BackView()
            VStack {
                
                //MARK: - Title
                HStack(spacing: 10) {
                    Button {
                        dismiss()
                        completion()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                    Spacer()
                    
                    if let _ = realmGrade {
                        Button {
                            imageToShare = createSnapshot()
                            isSnapshotShown.toggle()
                        } label: {
                            Image(systemName: "camera.shutter.button")
                        }
                        .padding(.trailing)
                    }
                    
                    Button {
                        if let grade = realmGrade {
                            StorageManager.shared.updateGradeList(id: grade.id, name: nameList, list: vm.gradeCategory)
                            dismiss()
                            completion()
                        } else {
                            if !vm.gradeCategory.isEmpty {
                                StorageManager.shared.createNewGradeList(name: nameList, list: vm.gradeCategory)
                                dismiss()
                                completion()
                            }
                        }
                        
                    } label: {
                        Text("Save")
                    }
                }
                .foregroundColor(.white)
                .padding(.top)
                .padding(.horizontal, 20)
                .overlay {
                    HStack {
                        Spacer()
                        
                        Text("Grade List")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                
                TextField("Enter a name for the list", text: $nameList)
                    .padding()
                    .background(Color.softBlue)
                    .cornerRadius(12)
                    .frame(width: screenSize().width - 30)
                    .foregroundStyle(.white)
                ScrollView {
                    HStack {
                        VStack {
                            ForEach(grades, id: \.self) { tier in
                                ZStack {
                                    Rectangle()
                                        .frame(width: 60, height: 100)
                                        .cornerRadius(12)
                                        .foregroundColor(getColor(tier: tier))
                                        .overlay {
                                            if tier == "1" {
                                                Text(tier)
                                                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                    .foregroundColor(.white)
                                            } else {
                                                Text(tier)
                                                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                    .foregroundColor(.white)
                                                    .glow(.softBlue, radius: 1)
                                                
                                            }
                                            
                                        }
                                }
                            }
                        }
                        
                        VStack {
                            ForEach(0..<vm.gradeCategory.count, id: \.self) { index in
                                GradeCell(gradeElement: $vm.gradeCategory[index])
                                   
                            }
                         
                        }
                    }
                    .padding(.top, 10)
                }
                
                .padding(.horizontal)
                .hideScrollIndicator()
            }
        }
        .fullScreenCover(isPresented: $isSnapshotShown) {
            if let image = imageToShare {
                SharingImage(image: image)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .onAppear {
            if let grade = realmGrade {
                vm.gradeCategory = []
                vm.grade10.image = grade.grade10.first?.image
                vm.grade10.note = grade.grade10.first?.note ?? ""
                
                vm.grade9.image = grade.grade9.first?.image
                vm.grade9.note = grade.grade9.first?.note ?? ""
                
                vm.grade8.image = grade.grade8.first?.image
                vm.grade8.note = grade.grade8.first?.note ?? ""
                
                vm.grade7.image = grade.grade7.first?.image
                vm.grade7.note = grade.grade7.first?.note ?? ""
                
                vm.grade6.image = grade.grade6.first?.image
                vm.grade6.note = grade.grade6.first?.note ?? ""
                
                vm.grade5.image = grade.grade5.first?.image
                vm.grade5.note = grade.grade5.first?.note ?? ""
                
                vm.grade4.image = grade.grade4.first?.image
                vm.grade4.note = grade.grade4.first?.note ?? ""
                
                vm.grade3.image = grade.grade3.first?.image
                vm.grade3.note = grade.grade3.first?.note ?? ""
                
                vm.grade2.image = grade.grade2.first?.image
                vm.grade2.note = grade.grade2.first?.note ?? ""
                
                vm.grade1.image = grade.grade1.first?.image
                vm.grade1.note = grade.grade1.first?.note ?? ""
                
                nameList = grade.gradeCategoryName
                
                vm.createGradeList()
            } else {
                vm.createGradeList()
            }
        }
       
    }
}

#Preview {
    GradeListMakerView(){}
}
