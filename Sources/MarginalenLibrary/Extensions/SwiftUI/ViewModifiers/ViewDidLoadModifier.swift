//
//  ViewDidLoadModifier.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-03-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    // MARK: Lifecycle

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    // MARK: Internal

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

    // MARK: Private

    @State private var didLoad = false
    private let action: (() -> Void)?
}
