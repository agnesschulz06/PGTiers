//
//  SnapshotView.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//



import SwiftUI

struct SnapshotView<Content: View>: UIViewControllerRepresentable {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    func makeUIViewController(context: Context) -> UIHostingController<Content> {
        return UIHostingController(rootView: content)
    }

    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: Context) {
        uiViewController.rootView = content
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

extension View {
    func createSnapshot() -> UIImage? {
        let hostingController = UIHostingController(rootView: self.body)
        guard let view = hostingController.view else { return nil }
        
        let targetSize = hostingController.view.intrinsicContentSize
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear

//        let window = UIApplication.shared.windows.first!
//        window.addSubview(view)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.addSubview(view)
            }
        }
        
        let image = view.asImage()
        
        view.removeFromSuperview()

        return image
    }
}
