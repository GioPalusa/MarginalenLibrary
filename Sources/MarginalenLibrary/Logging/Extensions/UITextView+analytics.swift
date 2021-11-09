//
//  UITextView+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-01-27.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import UIKit

extension UITextView {
    func logClick(label: String?,
                  category: AnalyticsManager.Category,
                  product: AnalyticsManager.Product,
                  position: Int? = nil,
                  header: String? = nil,
                  pageHeadline: String? = nil,
                  next: AnalyticsManager.Next? = nil) {
        let headline = pageHeadline == nil ? self.parentViewControllerTitle : pageHeadline

        let log = AnalyticsManager.Parameters(name: AnalyticsManager.Name.input.rawValue,
                                       action: AnalyticsManager.Action.click.rawValue,
                                       label: label,
                                       category: category.rawValue,
                                       product: product.name,
                                       iconName: nil,
                                       color: nil,
                                       position: position,
                                       type: AnalyticsManager.LogType.text.rawValue,
                                       header: header,
                                       linkType: nil,
                                       pageHeadline: headline,
                                       next: next?.destination)

        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
