//
//  MovingGrids.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//

import SwiftUI

struct MovingGrids: View {
    @Binding var images: [ImageItem]

    @State var draggingItem: ImageItem?
    
    @State private var isShown: Bool? = false
    @State private var image: UIImage?
    @State private var isImageShown: Bool = false
    
    @State private var imageToShown: Image?
    @State private var idToDelete: UUID?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    ForEach(images) { item in
                        GeometryReader { geometry in
                            let size = geometry.size

                            if let image = item.swiftUIImage {
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onTapGesture {
                                        print("Tapped")
                                        imageToShown = image
                                        idToDelete = item.id
                                        isImageShown.toggle()
                                    }
                                    /// Drag
                                    .draggable(item) {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(.ultraThinMaterial)
                                            .frame(width: size.width, height: size.height)
                                            .onAppear {
                                                draggingItem = item
                                            }
                                    }
                                    /// Drop
                                    .dropDestination(for: ImageItem.self) { items, location in
                                        draggingItem = nil
                                        return false
                                    } isTargeted: { status in
                                        if let draggingItem = draggingItem, status, draggingItem != item {
                                            if let sourceIndex = images.firstIndex(of: draggingItem), let destinationIndex = images.firstIndex(of: item) {
                                                withAnimation(.bouncy) {
                                                    let sourceItem = images.remove(at: sourceIndex)
                                                    images.insert(sourceItem, at: destinationIndex)
                                                }
                                            }
                                        }
                                    }
                            }
                                
                        }
                        .frame(width: 100, height: 100)
                    }

                    Button {
                        withAnimation {
                            isShown?.toggle()
                        }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                    }
                }
            }
            .hideScrollIndicator()
        }
        .fullScreenCover(isPresented: $isImageShown) {
            if let image = imageToShown {
                ImageRedactorView(image: image) {
                    withAnimation {
                        removeImage()
                    }
                }
            }
        }
        .halfSheet(showSheet: $isShown) {
            BottomSheetView(selectedImage: $image) {
                withAnimation {
                    isShown = false
                    
                    if let image = image {
                        let imageItem = ImageItem(image: image)
                        images.append(imageItem)
                    }
                }
            } closing: {
                isShown = false
            }
        } onDismiss: {
        }
    }
    
    func removeImage() {
        guard let id = idToDelete else { return }

        // Найти идентификатор изображения, которое нужно удалить
        if let imageItem = images.first(where: { $0.id == id }) {
            // Удалить элемент из массива по идентификатору
            print("deleted")
            images.removeAll { $0.id == imageItem.id }
        }
    }
    
    func removeImage(from images: inout [ImageItem], imageToRemove: Image?) {
        guard let imageToRemove = imageToRemove else { return }

        // Преобразуем Image в UIImage для сравнения
        let uiImageToRemove = imageToRemove.asUIImage()

        // Найдем объект ImageItem с соответствующим изображением
        if let index = images.firstIndex(where: { $0.uiImage == uiImageToRemove }) {
            images.remove(at: index)
        }
    }
}

//#Preview {
//    MovingGrids()
//}



extension Image {
    // Вспомогательный метод для преобразования Image в UIImage
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(size: controller.view.bounds.size)
        return renderer.image { _ in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
