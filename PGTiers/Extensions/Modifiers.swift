//
//  Modifiers.swift
//  PGTiers
//
//  Created by admin on 6/24/24.
//


import SwiftUI


struct HideTabBar: ViewModifier {
        
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbar(.hidden, for: .tabBar)
        } else {
            content
        }
    }
}


struct NavBarBackground: ViewModifier {
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbarBackground(.hidden, for: .navigationBar)
        } else {
            content
        }
    }
}
