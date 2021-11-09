//
//  ButtonShadow.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-15.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct ButtonShadow: ViewModifier {
    func body(content: Content) -> some View {
        content
        .clipped()
        .shadow(color: Color(UIColor.black.withAlphaComponent(0.3)), radius: 6)
    }
}
