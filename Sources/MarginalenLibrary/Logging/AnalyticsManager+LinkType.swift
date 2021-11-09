//
//  AnalyticsManager+LinkType.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
    enum Linktype: String, Codable {
        case internalLink = "Internal"
        case external = "External"
        case pdf = "PDF"
        case toggle = "Toggle"
    }
}
