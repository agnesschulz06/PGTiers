//
//  RealmGrade.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import Foundation
import RealmSwift


class GradeList: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var gradeCategoryName: String = ""

    @Persisted var grade10 = RealmSwift.List<GradeElement>()
    @Persisted var grade9 = RealmSwift.List<GradeElement>()
    @Persisted var grade8 = RealmSwift.List<GradeElement>()
    @Persisted var grade7 = RealmSwift.List<GradeElement>()
    @Persisted var grade6 = RealmSwift.List<GradeElement>()
    @Persisted var grade5 = RealmSwift.List<GradeElement>()
    @Persisted var grade4 = RealmSwift.List<GradeElement>()
    @Persisted var grade3 = RealmSwift.List<GradeElement>()
    @Persisted var grade2 = RealmSwift.List<GradeElement>()
    @Persisted var grade1 = RealmSwift.List<GradeElement>()
}

class GradeElement: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var note = ""
    @Persisted var image: Data?
}
