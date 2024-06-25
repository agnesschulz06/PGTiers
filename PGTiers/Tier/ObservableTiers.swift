//
//  ObservableTiers.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI
import Combine

class ObservableTiers: ObservableObject {
    @Published var sTier: [ImageItem] = []
    @Published var aTier: [ImageItem] = []
    @Published var bTier: [ImageItem] = []
    @Published var cTier: [ImageItem] = []
    @Published var dTier: [ImageItem] = []
    @Published var eTier: [ImageItem] = []
    @Published var fTier: [ImageItem] = []

    var cancellables = Set<AnyCancellable>()

    init() {
        $sTier
            .merge(with: $aTier, $bTier, $cTier, $dTier, $eTier, $fTier)
            .sink { _ in
                self.updateAllTiers()
            }
            .store(in: &cancellables)
    }

    @Published var allTiers: [[ImageItem]] = []

    private func updateAllTiers() {
        allTiers = [sTier, aTier, bTier, cTier, dTier, eTier, fTier]
    }
}
