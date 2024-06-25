//
//  SharingImage.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//

import SwiftUI


struct SharingImage: View {
    
    @Environment(\.dismiss) var dismiss
    @State var showImageSheet = false
    @State var isAlertShown = false
    var image: UIImage
    
    var body: some View {
        ZStack {
            BackView()
            
            VStack {
                ScrollView {
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: screenSize().height)
                    }
                }
                .padding(.top, 50)
                
                
                
                Spacer()
                
                Rectangle()
                    .frame(height: 130)
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                    .foregroundColor(.softBlue)
                    .glow(.softBlue, radius: 10)
                    .shadow(radius: 10)
                    .overlay {
                        HStack {
                            Button {
                                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                                isAlertShown.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                                        .cornerRadius(12)
                                        .foregroundStyle(Color.darkBlue)
                                    HStack {
                                        Image(systemName: "square.and.arrow.down")
                                        
                                        Text("Save")
                                    }
                                }
                            }
                            .alert("Success!", isPresented: $isAlertShown) {
                                
                            } message: {
                                Text("The image has been saved to the media library.")
                            }

                            
                            Button {
                                showImageSheet = true
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 50)
                                        .cornerRadius(12)
                                        .foregroundStyle(Color.darkBlue)
                                    HStack {
                                        Image(systemName: "square.and.arrow.up")
                                        
                                        Text("Share")
                                    }
                                }
                                
                            }
                            .imageShareSheet(isPresented: $showImageSheet, image: image)
                                                    
                        }
                        .foregroundStyle(.white)
                    }
                
            }
            
            
        }
        .background(ignoresSafeAreaEdges: .bottom)
        .overlay {
            VStack {
                ZStack {
                    Text("Snapshot")
                        .font(.title)
                        .bold()
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}

#Preview {
    SharingImage(image: UIImage(named: "logo")!)
}


struct ImageShareSheet: UIViewControllerRepresentable {
    /// The images to share
    let images: UIImage
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let activityViewController = UIActivityViewController(activityItems: [images], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.addToReadingList, .assignToContact]
        return activityViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

extension View {
    func imageShareSheet(
        isPresented: Binding<Bool>,
        image: UIImage
    ) -> some View {
        return sheet(isPresented: isPresented, content: { ImageShareSheet(images: image) } )
    }
}
