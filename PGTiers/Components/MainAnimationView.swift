//
//  MainAnimationView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//

import SwiftUI

struct MainAnimationView: View {

    @State private var degree: Double = 0
        
        var body: some View {
            ZStack {
                CircularText(rad: 200, text: "PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers PG Tiers")
                     .rotationEffect(.degrees(degree))
                     .animation(Animation.linear(duration: 10).repeatForever(autoreverses: false), value: degree)
                     .scaleEffect(0.7)
                
                Image("logo")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
            }
            .onAppear {
                rotation()
            }
                
        }
    
    func rotation() {
        withAnimation {
            degree = 0
            degree += 360
        }
    }
}
    

#Preview {
    MainAnimationView()
        .preferredColorScheme(.dark)
}



struct CircularText: View {
    var rad: Double
    var text: String
    var ker: CGFloat = 5.0
    
    private var array: [(offset: Int, element:Character)] {
        return Array(text.enumerated())
    }
    
    @State var size: [Int:Double] = [:]
    
    var body: some View {
        ZStack {
            ForEach(self.array, id: \.self.offset) { (offset, element) in
                VStack {
                    Text(String(element))
                        .foregroundColor(.white)
                        .kerning(self.ker)
                        .background(Sizeable())
                        .onPreferenceChange(WidthKey.self, perform: { size in
                            self.size[offset] = Double(size)
                        })
                    Spacer()
                }
                .rotationEffect(self.newAngle(at: offset))
                
            }
        }.rotationEffect(-self.newAngle(at: self.array.count-1)/2)
            
        .frame(width: 300, height: 300, alignment: .center)
    }
    
    private func newAngle(at index: Int) -> Angle {
        guard let labelSize = size[index] else {return .radians(0)}
        let percentOfLabelInCircle = labelSize / rad.perimeter
        let labelAngle = 2 * Double.pi * percentOfLabelInCircle
        
        
        let totalSizeOfPreChars = size.filter{$0.key < index}.map{$0.value}.reduce(0,+)
        let percenOfPreCharInCircle = totalSizeOfPreChars / rad.perimeter
        let angleForPreChars = 2 * Double.pi * percenOfPreCharInCircle
        
        return .radians(angleForPreChars + labelAngle)
    }
    
}



extension Double {
    var perimeter: Double {
        return self * 2 * .pi
    }
}


struct WidthKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat(0)
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
struct Sizeable: View {
    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: WidthKey.self, value: geometry.size.width)
        }
    }
}
