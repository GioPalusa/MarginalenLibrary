//
//  AlignmentStyles.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-08-10.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct LeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
        }
    }
}

struct TrailingStyle: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
        }
    }
}

extension Text {
    func leadingAlignment() -> some View {
        return self.modifier(LeadingStyle())
    }

    func trailingAlignment() -> some View {
        return self.modifier(TrailingStyle())
    }
}
