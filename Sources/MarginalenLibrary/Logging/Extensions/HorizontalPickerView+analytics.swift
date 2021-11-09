//
//  HorizontalPickerView+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-02-10.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import UIKit

extension HorizontalPickerView {
    func log(direction: AnalyticsManager.Direction,
             category: AnalyticsManager.Category,
             product: AnalyticsManager.Product,
             position: Int,
             header: String?) {
        AnalyticsManager.log(name: .slider,
                             action: .swipe,
                             label: direction.rawValue,
                             category: category,
                             product: product,
                             iconName: nil,
                             color: nil,
                             position: position,
                             type: .sliderAmount,
                             linkType: .internalLink,
                             header: header,
                             pageHeadline: parentViewControllerTitle,
                             next: nil)
    }
}
