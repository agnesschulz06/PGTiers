//
//  ImageItem.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI

extension UIImage {
    func toData() -> Data? {
        return self.jpegData(compressionQuality: 1.0)
    }
}

struct ImageItem: Identifiable, Hashable, Transferable, Codable {
        var id = UUID()
        var image: Data

        init(image: UIImage) {
            self.image = image.toData() ?? Data()
        }

        var uiImage: UIImage? {
            return UIImage(data: image)
        }

        var swiftUIImage: Image? {
            guard let uiImage = uiImage else { return nil }
            return Image(uiImage: uiImage)
        }

    // MARK: - Hashable Conformance
    static func == (lhs: ImageItem, rhs: ImageItem) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    // MARK: - Transferable Conformance
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(for: ImageItem.self, contentType: .plainText)
    }

    // MARK: - Codable Conformance
    enum CodingKeys: String, CodingKey {
        case id, imageData
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        image = try container.decode(Data.self, forKey: .imageData)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(image, forKey: .imageData)
    }
}
