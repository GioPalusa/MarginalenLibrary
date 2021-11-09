//
//  FocusModifier.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-08-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct FocusModifier: ViewModifier {
    @Binding var isFocused: Bool?

    init(isFocused: Binding<Bool?>?) {
        self._isFocused = isFocused ?? .constant(nil)
    }

    func body(content: Content) -> some View {
        content
            .onTapGesture {
                isFocused = true
            }
    }
}

extension View {
    func setFocus(focus: Binding<Bool?>?) -> some View {
        self.modifier(FocusModifier(isFocused: focus))
    }
}
