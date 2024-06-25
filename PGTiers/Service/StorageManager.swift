//
//  StorageManager.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI
import RealmSwift


class StorageManager {
    
    @ObservedResults(TierList.self) var tierLists
    @ObservedResults(GradeList.self) var gradeLists
    @ObservedResults(CustomGradeList.self) var customGradeLists

    
    static let shared = StorageManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    
    
    func deleteAllData() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            print("Ошибка при удалении данных из Realm: \(error.localizedDescription)")
        }
    }
    
    //MARK: - TIERS

    func updateTierList(id: ObjectId, name: String, list: [[ImageItem]]) {
        // Находим объект TierList по его ID
        if let tierListToUpdate = realm.object(ofType: TierList.self, forPrimaryKey: id) {
            try! realm.write {
                tierListToUpdate.tierListName = name
                
                if let tierToUpdate = tierListToUpdate.tiers.first {
                    tierToUpdate.sTier.removeAll()
                    tierToUpdate.aTier.removeAll()
                    tierToUpdate.bTier.removeAll()
                    tierToUpdate.cTier.removeAll()
                    tierToUpdate.dTier.removeAll()
                    tierToUpdate.eTier.removeAll()
                    tierToUpdate.fTier.removeAll()

                    let sTierData = list[0].map { $0.image }
                    let aTierData = list[1].map { $0.image }
                    let bTierData = list[2].map { $0.image }
                    let cTierData = list[3].map { $0.image }
                    let dTierData = list[4].map { $0.image }
                    let eTierData = list[5].map { $0.image }
                    let fTierData = list[6].map { $0.image }
                    
                    tierToUpdate.sTier.append(objectsIn: sTierData)
                    tierToUpdate.aTier.append(objectsIn: aTierData)
                    tierToUpdate.bTier.append(objectsIn: bTierData)
                    tierToUpdate.cTier.append(objectsIn: cTierData)
                    tierToUpdate.dTier.append(objectsIn: dTierData)
                    tierToUpdate.eTier.append(objectsIn: eTierData)
                    tierToUpdate.fTier.append(objectsIn: fTierData)
                }
            }
        } else {
            print("TierList with id \(id) not found")
        }
    }
    
    func createNewTierList(name: String, list: [[ImageItem]]) {

        let newTierList = TierList()
        newTierList.tierListName = name
        
        let newTiers = Tier()
        
        let sTierData = list[0].map { $0.image }
        let aTierData = list[1].map { $0.image }
        let bTierData = list[2].map { $0.image }
        let cTierData = list[3].map { $0.image }
        let dTierData = list[4].map { $0.image }
        let eTierData = list[5].map { $0.image }
        let fTierData = list[6].map { $0.image }
        
        
        newTiers.sTier.append(objectsIn: sTierData)
        newTiers.aTier.append(objectsIn: aTierData)
        newTiers.bTier.append(objectsIn: bTierData)
        newTiers.cTier.append(objectsIn: cTierData)
        newTiers.dTier.append(objectsIn: dTierData)
        newTiers.eTier.append(objectsIn: eTierData)
        newTiers.fTier.append(objectsIn: fTierData)
        
        newTierList.tiers.append(newTiers)
        
        $tierLists.append(newTierList)
    }
    
    //MARK: - GRADES
    
    func createNewGradeList(name: String, list: [GradeElement]) {

        let newGradeCategory = GradeList()
        newGradeCategory.gradeCategoryName = name
        
        newGradeCategory.grade10.append(list[0])
        newGradeCategory.grade9.append(list[1])
        newGradeCategory.grade8.append(list[2])
        newGradeCategory.grade7.append(list[3])
        newGradeCategory.grade6.append(list[4])
        newGradeCategory.grade5.append(list[5])
        newGradeCategory.grade4.append(list[6])
        newGradeCategory.grade3.append(list[7])
        newGradeCategory.grade2.append(list[8])
        newGradeCategory.grade1.append(list[9])
        
        $gradeLists.append(newGradeCategory)
    }
    
    func updateGradeList(id: ObjectId, name: String, list: [GradeElement]) {
        guard let gradeListToUpdate = realm.object(ofType: GradeList.self, forPrimaryKey: id) else {
            print("GradeList not found")
            return
        }

        try! realm.write {
            gradeListToUpdate.gradeCategoryName = name
            
            let elementsToDelete10 = RealmSwift.List<GradeElement>()
            elementsToDelete10.append(objectsIn: gradeListToUpdate.grade10)
            realm.delete(elementsToDelete10)

            let elementsToDelete9 = RealmSwift.List<GradeElement>()
            elementsToDelete9.append(objectsIn: gradeListToUpdate.grade9)
            realm.delete(elementsToDelete9)

            let elementsToDelete8 = RealmSwift.List<GradeElement>()
            elementsToDelete8.append(objectsIn: gradeListToUpdate.grade8)
            realm.delete(elementsToDelete8)

            let elementsToDelete7 = RealmSwift.List<GradeElement>()
            elementsToDelete7.append(objectsIn: gradeListToUpdate.grade7)
            realm.delete(elementsToDelete7)

            let elementsToDelete6 = RealmSwift.List<GradeElement>()
            elementsToDelete6.append(objectsIn: gradeListToUpdate.grade6)
            realm.delete(elementsToDelete6)

            let elementsToDelete5 = RealmSwift.List<GradeElement>()
            elementsToDelete5.append(objectsIn: gradeListToUpdate.grade5)
            realm.delete(elementsToDelete5)

            let elementsToDelete4 = RealmSwift.List<GradeElement>()
            elementsToDelete4.append(objectsIn: gradeListToUpdate.grade4)
            realm.delete(elementsToDelete4)

            let elementsToDelete3 = RealmSwift.List<GradeElement>()
            elementsToDelete3.append(objectsIn: gradeListToUpdate.grade3)
            realm.delete(elementsToDelete3)

            let elementsToDelete2 = RealmSwift.List<GradeElement>()
            elementsToDelete2.append(objectsIn: gradeListToUpdate.grade2)
            realm.delete(elementsToDelete2)

            let elementsToDelete1 = RealmSwift.List<GradeElement>()
            elementsToDelete1.append(objectsIn: gradeListToUpdate.grade1)
            realm.delete(elementsToDelete1)

            gradeListToUpdate.grade10.append(list[0])
            gradeListToUpdate.grade9.append(list[1])
            gradeListToUpdate.grade8.append(list[2])
            gradeListToUpdate.grade7.append(list[3])
            gradeListToUpdate.grade6.append(list[4])
            gradeListToUpdate.grade5.append(list[5])
            gradeListToUpdate.grade4.append(list[6])
            gradeListToUpdate.grade3.append(list[7])
            gradeListToUpdate.grade2.append(list[8])
            gradeListToUpdate.grade1.append(list[9])
        }
    }



    //MARK: - CUSTOM GRADES

    func createNewCustomGradeList(name: String, list: [CustomGradeElement]) {

        let newGradeCategory = CustomGradeList()
        newGradeCategory.gradeCategoryName = name
        
        for element in list {
            newGradeCategory.grades.append(element)
        }
        
        $customGradeLists.append(newGradeCategory)
    }
    
    func updateCustomGradeList(id: ObjectId, name: String, list: [CustomGradeElement]) {
        guard let gradeListToUpdate = realm.object(ofType: CustomGradeList.self, forPrimaryKey: id) else {
            print("GradeList not found")
            return
        }

        try! realm.write {
            gradeListToUpdate.gradeCategoryName = name

            let elementsToDelete = RealmSwift.List<CustomGradeElement>()
            elementsToDelete.append(objectsIn: gradeListToUpdate.grades)
            realm.delete(elementsToDelete)

            for element in list {
                let newElement = CustomGradeElement()
                newElement.note = element.note
                newElement.image = element.image
                newElement.color = element.color
                newElement.grade = element.grade

                gradeListToUpdate.grades.append(newElement)
            }
        }
    }
    
}
