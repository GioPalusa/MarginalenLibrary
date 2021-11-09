//
//  SwedishCrownsFormatter.swift
//  Marginalen
//
//  Created by Denis Leal on 2019-04-15.
//  Copyright © 2019 Marginalen Bank. All rights reserved.
//

import Foundation

class SwedishCrownsFormatter: NumberFormatter {

    enum Settings {
        /**
         Shows no decimals

         Use this to exclude decimals

         **Example:** `100.00` will be shown as `100`
         */
        case noDecimals

        /**
         Shows no currency symbol.

         Use this when you want to exclude the currency symbol.

         **Example:** Instead of `100.00 kr` it will be `100.00`
         */
        case noCurrencySymbol

        /**
        Shows the currency code after the value

        Use this when you want the value to end with the currency code after the value.

        **Example:** `100.00` will be shown as `100.00 SEK`
        */
        case withFullCurrencyCode

        /**
        Shows the currency symbol after the value

        Use this when you want the value to end with the currency symbol after the value.

        **Example:** `100.00` will be shown as `100.00 kr`
        */
        case withCurrencySymbol
    }

    // MARK: Init
    override init() {
        super.init()
        locale = Locale(identifier: "sv_SE")
        numberStyle = .currency
        usesGroupingSeparator = true
        groupingSeparator = " "
        minimumFractionDigits = 2
        maximumFractionDigits = 2
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    /**
     Formatter which includes the default settings, but does not present currency symbol.

     When formatting with this formatter it will exclude the currency symbol at the end of the formatted value and format it in decimal style.
     **Example:** "`1000`" will be shown as "`1 000,00`"

     - Warning: Do not use this formatter if you want to present currency at the end of the formatted value.
    */
    static var standard: SwedishCrownsFormatter {
        let formatter = SwedishCrownsFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }

    /// Returns formatted value with the chosen settings.
    ///
    /// - Parameters:
    ///     - value: A value which conforms to the `SignedNumeric` protocol.
    ///     - settings: Three different settings available: `noDecimals`, `noCurrencySymbol` and `withFullCurrencyCode`.
    static func format<T: SignedNumeric>(_ value: T, settings: [Settings] = []) -> String {
        let formatter = SwedishCrownsFormatter()
        for setting in settings {
            switch setting {
            case .noDecimals: formatter.maximumFractionDigits = 0
            case .noCurrencySymbol:
                formatter.currencySymbol = ""
                formatter.numberStyle = .decimal
            case .withFullCurrencyCode: formatter.numberStyle = .currencyISOCode
            case .withCurrencySymbol: formatter.numberStyle = .currency
            }
        }
        return formatter.string(from: NSNumber(value: value))?.replacingOccurrences(of: "\u{A0}", with: " ") ?? ""
    }

    /// Formats the value with the `standard` formatter
    static func format<T: SignedNumeric>(_ value: T) -> String {
        return standard.string(from: NSNumber(value: value)) ?? ""
    }

    func format<T: SignedNumeric>(_ value: T) -> String {
        return string(from: NSNumber(value: value)) ?? ""
    }
}
