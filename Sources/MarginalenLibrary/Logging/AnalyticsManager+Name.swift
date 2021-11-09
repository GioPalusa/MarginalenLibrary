//
//  AnalyticsManager+Name.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
    enum Name: String, Codable {
        // MARK: - General
        case pageSwipe = "page_swipe"
        case slider
        case icon
        case list
        case button
        case tab
        case input
        case handelserCard = "handelser_card"
        case picker
        case checkbox
    }
}
