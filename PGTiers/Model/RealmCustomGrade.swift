//
//  RealmCustomGrade.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import SwiftUI
import RealmSwift


class CustomGradeList: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var gradeCategoryName: String = ""

    @Persisted var grades = RealmSwift.List<CustomGradeElement>()
}

class CustomGradeElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var note = ""
    @Persisted var grade = ""
    @Persisted var color: ColorObject?
    @Persisted var image: Data?
}




class ColorObject: Object {
    @Persisted var red: Double?
    @Persisted var green: Double?
    @Persisted var blue: Double?
    @Persisted var alpha: Double?
}

//extension CustomGradeList: Sequence {
//    func makeIterator() -> IndexingIterator<RealmSwift.List<CustomGradeElement>> {
//        return grades.makeIterator()
//    }
//}
