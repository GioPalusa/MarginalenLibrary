//
//  UIPickerView+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-19.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import UIKit

extension UIPickerView {
    func log(direction: AnalyticsManager.Direction,
             category: AnalyticsManager.Category,
             product: AnalyticsManager.Product,
             type: AnalyticsManager.LogType = .slider,
             fromPosition: Int,
             header: String?) {
        AnalyticsManager.log(event: .interaction,
                             name: .slider,
                             action: .swipe,
                             label: direction.rawValue,
                             category: category,
                             product: product,
                             iconName: nil,
                             color: nil,
                             position: fromPosition,
                             type: type,
                             linkType: nil,
                             header: header,
                             pageHeadline: parentViewControllerTitle,
                             next: nil)
    }
}
