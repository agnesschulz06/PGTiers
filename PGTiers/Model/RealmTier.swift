//
//  RealmTier.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import Foundation
import RealmSwift


class TierList:  Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    
    @Persisted var tierListName: String = ""
    @Persisted var tiers = RealmSwift.List<Tier>()
}

class Tier: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId

    @Persisted var sTier = RealmSwift.List<Data>()
    @Persisted var aTier = RealmSwift.List<Data>()
    @Persisted var bTier = RealmSwift.List<Data>()
    @Persisted var cTier = RealmSwift.List<Data>()
    @Persisted var dTier = RealmSwift.List<Data>()
    @Persisted var eTier = RealmSwift.List<Data>()
    @Persisted var fTier = RealmSwift.List<Data>()
}
