//
//  CustomGradeCell.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import SwiftUI

struct CustomGradeCell: View {
    
    @State private var isImagePickerShown: Bool? = false
    @State private var image: UIImage?
    @Binding var gradeElement: CustomGradeElement
    
    
    
    var body: some View {
        ZStack {
            HStack {
                
                Button {
                    isImagePickerShown?.toggle()
                } label: {
                    if let imageData = gradeElement.image, let imageui = UIImage(data: imageData) {
                        Image(uiImage: imageui)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                            .foregroundColor(.darkBlue)
                    } else {
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                            .foregroundColor(.darkBlue)
                            .overlay {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(lineWidth: 0.2)
                                    Image(systemName: "plus")
                                }
                                .foregroundStyle(.white)
                                
                            }
                    }
                }
                
                ZStack {
                    Rectangle()
                        .frame(height: 100)
                        .cornerRadius(12)
                        .foregroundColor(.softBlue)
                        .overlay {
                            TextEditor(text: $gradeElement.note)
                                .scrollContentBackground(.hidden)
                                .frame(height: 100)
                                .padding(.horizontal)
                                .foregroundColor(.white)
                                .background(Color.softBlue)
                                .cornerRadius(12)
                        }
                }
            }
        }
        .halfSheet(showSheet: $isImagePickerShown) {
            BottomSheetView(selectedImage: $image) {
                withAnimation {
                    isImagePickerShown = false
                    
                    if let image = image {
                        gradeElement.image = image.pngData()
                    }
                }
            } closing: {
                isImagePickerShown = false
            }
        } onDismiss: {
        }
    }
}

#Preview {
    CustomGradeCell(gradeElement: .constant(CustomGradeElement()))
}
