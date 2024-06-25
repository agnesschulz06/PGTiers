//
//  TierListMakerView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import SwiftUI


struct TierListMakerView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var observableTiers = ObservableTiers()
    @State var isShown = true
    @State var nameList = ""
    @State var imageToShare: UIImage?
    @State var isSnapshotShown = false
    
    var tiers = ["S", "A", "B", "C", "D", "E", "F"]
    
    var realmTierList: TierList?
    
    var completion: () -> ()
    
    var body: some View {
        ZStack {
            BackView()
            VStack {
                
                //MARK: - Title
                HStack(spacing: 10) {
                    Button {
                        
                        dismiss()
                        completion()
                    } label: {
                        Image(systemName: "xmark")
                    }
                                        
                    Spacer()
                    
                    if let _ = realmTierList {
                        Button {
                            imageToShare = createSnapshot()
                            isSnapshotShown.toggle()
                        } label: {
                            Image(systemName: "camera.shutter.button")
                        }
                        .padding(.trailing)
                    }
                    
                    Button {
                        
                        if let list = realmTierList {
                            StorageManager.shared.updateTierList(id: list.id, name: nameList, list: observableTiers.allTiers)
                        } else {
                            StorageManager.shared.createNewTierList(name: nameList, list: observableTiers.allTiers)
                        }
                        
                        dismiss()
                        completion()
                    } label: {
                        Text("Save")
                    }
                }
                .foregroundColor(.white)
                .padding(.top)
                .padding(.horizontal, 20)
                .overlay {
                    HStack {
                        Spacer()
                        
                        Text("Tier List")
                            .font(.system(size: 28, weight: .black))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        Spacer()
                    }
                }
                
                TextField("Enter a name for the list", text: $nameList)
                    .padding()
                    .background(Color.softBlue)
                    .cornerRadius(12)
                    .frame(width: screenSize().width - 30)
                    .foregroundStyle(.white)
                
                if isShown {
                    HStack {
                        ScrollView {
                            HStack {
                                //MARK: - Vertical ranking
                                VStack {
                                    
                                    ForEach(tiers, id: \.self) { tier in
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 100, height: 100)
                                                .cornerRadius(12)
                                                .foregroundColor(getColor(tier: tier))
                                                .overlay {
                                                    Text(tier)
                                                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                                                        .foregroundColor(.white)
                                                        .glow(.softBlue, radius: 1)
                                                }
                                        }
                                    }
                                }
                                //MARK: - Tier components
                                ScrollView(.horizontal) {
                                    VStack {
                                        ForEach(observableTiers.allTiers.indices, id: \.self) { index in
                                            Rectangle()
                                                .frame(width: 1000, height: 100)
                                                .cornerRadius(12)
                                                .foregroundColor(.black)
                                                .overlay {
                                                    MovingGrids(images: $observableTiers.allTiers[index])
                                                }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.leading, 20)
                        }
                        .hideScrollIndicator()
                    }
                } else {
                    VStack {
                       ProgressView()
                            .controlSize(.large)
                    }
                    Spacer()
                }
            }
        }
        .fullScreenCover(isPresented: $isSnapshotShown) {
            if let image = imageToShare {
                SharingImage(image: image)
            }
        }
        .onAppear {
            if let tierList = realmTierList {
                isShown = false
                nameList = tierList.tierListName
                print("TIER LIST NAME: \(tierList.tierListName)")
                
                DispatchQueue.global(qos: .userInitiated).async {
                    // Работаем с локальными переменными, чтобы избежать прямого доступа к Realm из фона
                    var localSTier: [Data] = []
                    var localATier: [Data] = []
                    var localBTier: [Data] = []
                    var localCTier: [Data] = []
                    var localDTier: [Data] = []
                    var localETier: [Data] = []
                    var localFTier: [Data] = []
                    
                    // Считываем данные из Realm в основном потоке
                    DispatchQueue.main.sync {
                        for tier in tierList.tiers {
                            localSTier.append(contentsOf: tier.sTier)
                            localATier.append(contentsOf: tier.aTier)
                            localBTier.append(contentsOf: tier.bTier)
                            localCTier.append(contentsOf: tier.cTier)
                            localDTier.append(contentsOf: tier.dTier)
                            localETier.append(contentsOf: tier.eTier)
                            localFTier.append(contentsOf: tier.fTier)
                        }
                    }
                    
                    var newSTier: [ImageItem] = []
                    var newATier: [ImageItem] = []
                    var newBTier: [ImageItem] = []
                    var newCTier: [ImageItem] = []
                    var newDTier: [ImageItem] = []
                    var newETier: [ImageItem] = []
                    var newFTier: [ImageItem] = []
                    
                    // Обрабатываем данные в фоновом потоке
                    newSTier = localSTier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    newATier = localATier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    newBTier = localBTier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    newCTier = localCTier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    newDTier = localDTier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    newETier = localETier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    newFTier = localFTier.compactMap { UIImage(data: $0).map { ImageItem(image: $0) } }
                    
                    // Печатаем результаты в фоновом потоке
                    print("NEW S TIER COUNT: \(newSTier.count)")
                    print("NEW A TIER COUNT: \(newATier.count)")
                    print("NEW B TIER COUNT: \(newBTier.count)")
                    
                    // Обновляем UI на основном потоке
                    DispatchQueue.main.async {
                        observableTiers.allTiers = [newSTier, newATier, newBTier, newCTier, newDTier, newETier, newFTier]
                        isShown = true
                    }
                }
            }
        }
    }
}

#Preview {
    TierListMakerView(){}
}
