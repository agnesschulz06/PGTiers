//
//  CustomGradeMaker.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI

struct CustomGradeMaker: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = CustomGradeMakerViewModel()
    @State private var nameList = ""
    
    @State private var imageToShare: UIImage?
    @State private var isSnapshotShown = false
    
    @State private var isEditorShown = false
    
    @State private var gradeTextToChange = ""
    @State private var gradeIndexToChange = 0
    @State private var gradeColorToChange = Color.red
    

    var realmGrade: CustomGradeList?
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            BackView()
            if !vm.grades.isEmpty && !vm.colors.isEmpty {
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
                                StorageManager.shared.updateCustomGradeList(id: grade.id, name: nameList, list: vm.gradeCategory)
                                dismiss()
                                completion()
                            } else {
                                if !vm.gradeCategory.isEmpty {
                                    StorageManager.shared.createNewCustomGradeList(name: nameList, list: vm.gradeCategory)
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
                    
                    //MARK: - NAME
                    TextField("Enter a name for the list", text: $nameList)
                        .padding()
                        .background(Color.softBlue)
                        .cornerRadius(12)
                        .frame(width: screenSize().width - 30)
                        .foregroundStyle(.white)
                    
                    //MARK: - GRADES
                    ScrollView {
                        HStack {
                            VStack {
                                ForEach(0..<vm.grades.count, id: \.self) { index in
                                    ZStack {
                                        Rectangle()
                                            .frame(width: 60, height: 100)
                                            .cornerRadius(12)
                                            .foregroundColor(vm.colors[index])
                                            .overlay {
                                                if vm.grades[index] == "?" {
                                                    Image(systemName: "hand.tap")
                                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                        .foregroundColor(.white)
                                                } else {
                                                    Text(vm.grades[index])
                                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                        .foregroundColor(.white)
                                                        .glow(.softBlue, radius: 1)
                                                }
                                                
                                            }
                                    }
                                    .onTapGesture {
                                        gradeIndexToChange = index
                                        gradeTextToChange = vm.grades[index]
                                        gradeColorToChange = vm.colors[index]
                                        isEditorShown.toggle()
                                    }
                                }
                            }
                            
                            VStack {
                                ForEach(0..<vm.gradeCategory.count, id: \.self) { index in
                                    CustomGradeCell(gradeElement: $vm.gradeCategory[index])
                                       
                                }
                             
                            }
                        }
                        .padding(.top, 10)
                        
                        //MARK: - AddNewLine
                        Button {
                            withAnimation {
                                let newLine = CustomGradeElement()
                                let newColor = ColorObject()
                                newColor.red = 0.5
                                newColor.green = 0.5
                                newColor.blue = 0.5
                                newColor.alpha = 1
                                
                                newLine.color = newColor
                                newLine.grade = "?"
                                
                                
                                vm.grades.append(newLine.grade)
                                vm.colors.append(vm.colorObjectToColor(colorObject: newColor))
                                vm.gradeCategory.append(newLine)
                            }
                            
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 80)
                                    .cornerRadius(12)
                                    .foregroundColor(.softBlue)
                                    .glow(.white.opacity(0.3), radius: 3)
                                
                                Text("Add new line")
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.top)
                    }
                    
                    .padding(.horizontal)
                    .hideScrollIndicator()
                    
                    
                }
            }
        }
        .sheet(isPresented: $isEditorShown) {
            ZStack {
                BackView()
                    
                VStack {
                    Rectangle()
                        .frame(width: 60, height: 100)
                        .cornerRadius(12)
                        .foregroundColor(gradeColorToChange)
                        .overlay {
                            Text(gradeTextToChange)
                                .font(.system(size: 32, weight: .bold, design: .monospaced))
                                .foregroundColor(.white)
                                .glow(.softBlue, radius: 1)
                        }
                        .padding(.top, 100)
                    
                    TextField("Enter a name for the list", text: $gradeTextToChange)
                        .padding()
                        .background(Color.softBlue)
                        .cornerRadius(12)
                        .frame(width: screenSize().width - 30)
                        .foregroundStyle(.white)
                        .padding(.top, 50)
                    
                    ColorPicker("Change grade color", selection: $gradeColorToChange, supportsOpacity: false)
                        .padding()
                        .background(Color.softBlue)
                        .cornerRadius(12)
                        .frame(width: screenSize().width - 30)
                        .foregroundStyle(.white)
                    
                    Button {
                        vm.grades[gradeIndexToChange] = gradeTextToChange
                        vm.colors[gradeIndexToChange] = gradeColorToChange
                        
                        vm.gradeCategory[gradeIndexToChange].grade = gradeTextToChange
                        vm.gradeCategory[gradeIndexToChange].color = vm.colorToColorObject(color: gradeColorToChange)

                        
                        isEditorShown.toggle()
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(width: 100, height: 60)
                                .cornerRadius(12)
                                .foregroundColor(.softBlue)
                            
                            Text("Apply")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                }
                
               
                
            }
            .overlay {
                VStack {
                    ZStack {
                        Text("Edit Grade")
                            .font(.title)
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.top, 30)
                        
                        HStack {
                            Button {
                                isEditorShown.toggle()
                            } label: {
                                 Image(systemName: "xmark")
                            }
                            .padding(.top, 35)
                            .padding(.leading, 20)
                            .foregroundColor(.white)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        //MARK: - ChangeTier
        .fullScreenCover(isPresented: $isSnapshotShown) {
            if let image = imageToShare {
                SharingImage(image: image)
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationBarHidden(true)
        .onAppear {
            
            if let list = realmGrade {
                vm.grades = []
                vm.colors = []
                vm.gradeCategory = []
                              
                for element in Array(list.grades) {
                    let newElement = CustomGradeElement()
                    newElement.note = element.note
                    newElement.image = element.image
                    newElement.color = element.color
                    newElement.grade = element.grade
                    vm.gradeCategory.append(newElement)
                }
                
                nameList = list.gradeCategoryName

                for element in vm.gradeCategory {
                    vm.grades.append(element.grade)
                    vm.colors.append(vm.colorObjectToColor(colorObject: element.color ?? ColorObject()))
                }
            } else {
                vm.createGradeList()
               
                vm.grades = []
                vm.colors = []
                if let grade = vm.gradeCategory.first?.grade, let color = vm.gradeCategory.first?.color {
                    vm.grades.append(grade)
                    vm.colors.append(vm.colorObjectToColor(colorObject: color))
                }
            }
        }
    }
}

#Preview {
    CustomGradeMaker(){}
}
