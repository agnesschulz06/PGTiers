//
//  ImageRedactorView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI

struct ImageRedactorView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var image: Image
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            BackView()
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                        completion()
                    } label: {
                        Text("Delete")
                    }
                }
                .foregroundStyle(.white)
                .padding(20)
                
                Spacer()
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 400)
                    .cornerRadius(12)
                
                Spacer()
            }
            
            
        }
    }
}

#Preview {
    ImageRedactorView(image: Image("logo")){}
}
