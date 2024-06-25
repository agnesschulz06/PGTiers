//
//  TierCell.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI


struct TierCell: View {
    
    var images: [Data]
    var name: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(LinearGradient(colors: [.darkBlue, .semiBlue, .semiBlue.opacity(0.75)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(12)
                .frame(height: 120)
                .padding(.horizontal, 20)
            
            HStack {
                ZStack {
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            if let uiImage0 = UIImage(data: images[0]) {
                                Image(uiImage: uiImage0)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .background(Color.red)
                            } else {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                            
                            if images.count > 1 {
                                if let uiImage1 = UIImage(data: images[1]) {
                                    Image(uiImage: uiImage1)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .background(Color.red)
                                }
                            } else {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        VStack(spacing: 0) {
                            if images.count > 2 {
                                if let uiImage2 = UIImage(data: images[2]) {
                                    Image(uiImage: uiImage2)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .background(Color.red)
                                }
                            } else {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                            
                            if images.count > 3 {
                                if let uiImage3 = UIImage(data: images[3]) {
                                    Image(uiImage: uiImage3)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .background(Color.red)
                                }
                            }
                            else {
                                Rectangle()
                                    .fill(Color.gray)
                                    .frame(width: 50, height: 50)
                            }
                        }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Spacer()
                    
                    Text(name)
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .bold))
                }
                .padding(.horizontal, 40)
            }
        }
    }
    
    #Preview {
        TierCell(images: [UIImage(named: "Tips")!.pngData()!, UIImage(named: "Tips")!.pngData()!,UIImage(named: "Tips")!.pngData()!,UIImage(named: "Tips")!.pngData()!], name: "Some Good Name")
        
    }
