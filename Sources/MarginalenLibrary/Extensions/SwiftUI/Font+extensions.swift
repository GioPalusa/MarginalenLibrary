//
//  Font+extensions.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-03-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - CustomFont

struct MarginalenFont: ViewModifier {
    let font: Font.Marginalen

    func body(content: Content) -> some View {
        content
            .font(.custom(font: font))
            .lineSpacing(font.lineHeight - font.font.lineHeight)
            .padding(.vertical, (font.lineHeight - font.font.lineHeight) / 2)
    }
}

extension View {
    func font(font: Font.Marginalen) -> some View {
        ModifiedContent(content: self, modifier: MarginalenFont(font: font))
    }
}

extension Font {
    static let fontRatio: CGFloat = UIDevice.current.isSmall ? 0.8 : 1

    enum Marginalen {
        /// Generellt / Stor rubrik - Size: 22
        case largeTitle

        /// Generellt / Vanlig rubrik - Size: 18
        case regularTitle

        /// Fält/ Rubrik - Size: 16
        case title

        /// Fält / Stor text - Size: 18
        case largeText

        /// Fält / Liten text - Size: 16
        case smallText

        /// Knappar / Markerad knapp - Size: 14
        case boldButtonText

        /// Knappar / Ej markerad knapp - Size: 14
        case regularButtonText

        /// Generellt / Ingress - Size: 14
        case ingress

        /// Generellt / Brödtext - Size: 14
        case body

        /// Övrigt / liten text - Size 12
        case otherSmallText

        var font: UIFont {
            var font: UIFont?
            switch self {
            case .largeTitle: font = UIFont(name: AppFontName.medium, size: 22 * Font.fontRatio)
            case .regularTitle: font = UIFont(name: AppFontName.medium, size: 18 * Font.fontRatio)
            case .title: font = UIFont(name: AppFontName.medium, size: 16 * Font.fontRatio)
            case .largeText: font = UIFont(name: AppFontName.regular, size: 18 * Font.fontRatio)
            case .smallText: font = UIFont(name: AppFontName.regular, size: 16 * Font.fontRatio)
            case .boldButtonText: font = UIFont(name: AppFontName.medium, size: 14 * Font.fontRatio)
            case .regularButtonText: font = UIFont(name: AppFontName.regular, size: 14 * Font.fontRatio)
            case .ingress: font = UIFont(name: AppFontName.medium, size: 14 * Font.fontRatio)
            case .body: font = UIFont(name: AppFontName.regular, size: 14 * Font.fontRatio)
            case .otherSmallText: font = UIFont(name: AppFontName.light, size: 12)
            }
            return font ?? UIFont.systemFont(ofSize: 16)
        }

        var lineHeight: CGFloat {
            switch self {
            case .ingress: return 24
            case .body: return 22
            default: return 20
            }
        }
    }

    static func custom(font: Marginalen) -> Font {
        Font(font.font as CTFont)
    }
}
