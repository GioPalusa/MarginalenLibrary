//
//  AnalyticsManager+Action.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
    public enum Action: String, Codable {
        case swipe
        case drag
        case click
        case open
        case approve
        case disapprove
        case update
    }
}
