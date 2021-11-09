//
//  AnalyticsManager+Category.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
	public enum Category: String, Codable {
        case accounts = "Konton"
        case creditcards = "Kreditkort och Bankkort"
        case digital = "Digitala tjänster"
        case loans = "Låna"
        case creditAccount = "Kreditkonton"
        case payment = "Betala och överföring"
        case unknown
    }
}
