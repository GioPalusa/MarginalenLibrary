//
//  AnalyticsManager+LogType.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
    enum LogType: String, Codable {
        case circle
        case `switch` = "switch button"
        case rectangle
        case header
        case menu
        case calendar
        case pickerlist = "picker_list"
        case navbar = "nav_bar"
        case popup = "pop-up"
        case onPage = "on-page"
        case slider
        case select
        case text
        case search
        case list
        case square
        case carousel
        case banner
        case sliderAmount = "slider_amount"
        case datepicker = "date_picker"
        case email = "email"
        case mobilePhone = "mobile_nr"
        case emailAndPhone = "email_and_phone"
    }
}
