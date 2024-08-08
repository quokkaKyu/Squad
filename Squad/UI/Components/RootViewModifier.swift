//
//  RootViewModifier.swift
//  Squad
//
//  Created by kyuminlee on 6/25/24.
//

import SwiftUI
import Combine

// MARK: - RootViewAppearance

struct RootViewAppearance: ViewModifier {
    @State private var isActive: Bool = false
    
    func body(content: Content) -> some View {
        content
    }
}
