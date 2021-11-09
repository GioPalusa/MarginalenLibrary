//
//  NavigationLazyView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
