//
//  UIScrollView+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-03-09.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import UIKit

extension UIScrollView {
    func log(direction: AnalyticsManager.Direction,
             fromPosition: Int,
             newPosition: Int,
             category: AnalyticsManager.Category,
             header: String?) {
        AnalyticsManager.log(name: .slider,
                             action: .swipe,
                             label: direction.rawValue,
                             category: category,
                             product: nil,
                             position: fromPosition,
                             type: .carousel,
                             linkType: nil,
                             header: header,
                             pageHeadline: parentViewControllerTitle,
                             next: .position(newPosition: newPosition))
    }
}
