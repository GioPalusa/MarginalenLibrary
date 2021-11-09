//
//  UIColor+extensions.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2019-07-09.
//  Copyright © 2019 Marginalen Bank. All rights reserved.
//

import UIKit.UIColor

extension UIColor {
    enum MarginalenColors: String {

        // Marginalen primary colors
        case primaryRed
        case darkBlue
        case yellow
        case cyan
        case green

        // Design set colors
        case banana
        case black
        case blackTwo
        case bluishGrey
        case borderColor
        case brightLightBlue
        case brightSkyBlue
        case checkboxColor
        case cobalt
        case cobaltTwo
        case coolGrey
        case darkIndigo
        case dividerColor
        case error
        case greenyBlue
        case greyishBrown
        case ice
        case iceBlue
        case lightBlueGrey
        case lightNavy
        case lightTeal
        case offWhite
        case pale
        case paleAqua
        case robinEggBlue
        case seafoamBlue
        case slateGrey
        case sunflowerYellow
        case sunshineYellow
        case veryLightPink
        case veryLightPinkTwo
        case veryLightPinkThree
        case primaryRedDarkMode
        case separator
        case pageIndicator

        // Pie charts
        case creditCards
        case savingsAccount

        // Others
        case lightNavyDarkMode
        case paleAquaDarkMode
        case trueCobalt
        case darkIndigoDarkMode

        var color: UIColor {
            UIColor(named: rawValue) ?? .black
        }

        var cgColor: CGColor {
            color.cgColor
        }
    }

    /// Name of color. Only colors created with XCode Color Assets will return actual name, colors created programatically will always return nil.
    var name: String? {
        let str = String(describing: self).dropLast()
        guard let nameRange = str.range(of: "name = ") else {
            return nil
        }
        let cropped = str[nameRange.upperBound ..< str.endIndex]
        if cropped.isEmpty {
            return nil
        }
        return String(cropped)
    }
}

extension UIImage {

    /// Extracts image name from a description.
    /// * Example description: `<UIImage:0x60000278ce10 named(main: ic_timeline_milestone_bluedot) {16, 16}>`
    /// * Example name: `ic_timeline_milestone_bluedot`
    /// - warning: For the debug use only.
    var name: String? {
        let description = self.description
        guard let regexp = try? NSRegularExpression(pattern: "\\(main: (.*)\\)", options: []) else { return nil }
        guard let match = regexp.matches(in: description, options: [], range: NSRange(location: 0, length: description.utf16.count)).first else { return nil }
        guard match.numberOfRanges > 0 else { return nil }
        let idx1 = description.index(description.startIndex, offsetBy: match.range.lowerBound)
        let idx2 = description.index(description.startIndex, offsetBy: match.range.upperBound)
        let result = String(description[idx1..<idx2])
        return result.replacingOccurrences(of: "(main: ", with: "").replacingOccurrences(of: ")", with: "")
    }
}
