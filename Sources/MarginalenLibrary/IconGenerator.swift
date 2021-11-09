//
//  IconGenerator.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-25.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import UIKit

enum IconGenerator: String {
    case close = "close_white"
    case rightChevron = "Right Detail"
    case select = "icon_select"
    case location = "icon_location"
    case phone = "icon_phone"
    case email = "icon_email"
    case plus = "icon_plus"
    case logo = "icon_marginalen"
    case copy = "icon_copy"
    case calendar = "calendar"
    case info = "icon_info.circle"
    case checkmark = "icon_checkmark"
    case error = "badge_error"

    var image: Image {
        return Image(self.rawValue)
    }

    static func asset(_ name: IconGenerator) -> Image {
        Image(name.rawValue)
    }
}
