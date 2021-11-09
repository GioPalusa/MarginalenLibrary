//
//  CloseNavigationButton.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-09-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct CloseNavigationButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Icon(.close)
        })
    }
}
