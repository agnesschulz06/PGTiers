//
//  CustomGradeMakerViewModel.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//

import SwiftUI

class CustomGradeMakerViewModel: ObservableObject {
    
    @Published var gradeCategory: [CustomGradeElement] = []
    
    @Published var grades: [String] = ["?"]
    @Published var colors: [Color] = [.red]
    
    
    @Published var firstGrade = CustomGradeElement()
    
    func createNewGrade() -> CustomGradeElement {
        let newLine = CustomGradeElement()
        let newColor = ColorObject()
        newColor.red = 0.5
        newColor.green = 0.5
        newColor.blue = 0.5
        newColor.alpha = 1
        
        newLine.color = newColor
        newLine.grade = "?"
        
        return newLine
    }
    
    func createGradeList() {
        gradeCategory.append(createNewGrade())
    }
    
    func colorObjectToColor(colorObject: ColorObject) -> Color {
        return Color(
            red: colorObject.red ?? 0.0,
            green: colorObject.green ?? 0.0,
            blue: colorObject.blue ?? 0.0,
            opacity: colorObject.alpha ?? 1.0
        )
    }
    
    func colorToColorObject(color: Color) -> ColorObject {
        let uiColor = UIColor(color)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        uiColor.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let colorObject = ColorObject()
        colorObject.red = Double(r)
        colorObject.green = Double(g)
        colorObject.blue = Double(b)
        colorObject.alpha = Double(a)
        
        return colorObject
    }
}