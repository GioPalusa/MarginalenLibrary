//
//  Color+extensions.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-17.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

extension Color {
    static func marginalen(color: UIColor.MarginalenColors) -> Color {
        Color(color.color)
    }

    static func marginalen(color: UIColor.MarginalenColors, withAlpha alpha: CGFloat) -> Color {
        Color(color.color.withAlphaComponent(alpha))
    }

    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemGroupedBackground = Color(UIColor.secondarySystemGroupedBackground)
    static let label = Color(UIColor.label)
}
