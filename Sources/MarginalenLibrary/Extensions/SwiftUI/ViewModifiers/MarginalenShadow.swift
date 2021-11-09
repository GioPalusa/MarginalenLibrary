//
//  MarginalenShadow.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-03-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct MarginalenShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipped()
            .shadow(color: Color(UIColor.black.withAlphaComponent(0.13)), radius: 20)
    }
}

struct MarginalenBottomShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipped()
            .shadow(color: Color(.gray.withAlphaComponent(0.13)), radius: 15, x: 0, y: 30)
    }
}
