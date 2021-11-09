//
//  DimmedOverlay.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-15.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct DimmedOverlay: ViewModifier {
    func body(content: Content) -> some View {
        content
        .clipped()
        .overlay(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
    }
}
