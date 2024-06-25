//
//  GradeListMakerViewModel.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import Foundation


class GradeListMakerViewModel: ObservableObject {
    
    @Published var gradeCategory: [GradeElement] = []
    
    @Published var grade10 = GradeElement()
    @Published var grade9 = GradeElement()
    @Published var grade8 = GradeElement()
    @Published var grade7 = GradeElement()
    @Published var grade6 = GradeElement()
    @Published var grade5 = GradeElement()
    @Published var grade4 = GradeElement()
    @Published var grade3 = GradeElement()
    @Published var grade2 = GradeElement()
    @Published var grade1 = GradeElement()
    
    func createGradeList() {
        gradeCategory.append(grade10)
        gradeCategory.append(grade9)
        gradeCategory.append(grade8)
        gradeCategory.append(grade7)
        gradeCategory.append(grade6)
        gradeCategory.append(grade5)
        gradeCategory.append(grade4)
        gradeCategory.append(grade3)
        gradeCategory.append(grade2)
        gradeCategory.append(grade1)
    }
    
}
