//
//  UITapGestureRecognizer+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-01-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import UIKit

extension UITapGestureRecognizer {
    func logClick(name: AnalyticsManager.Name = .button,
                  label: String?,
                  action: AnalyticsManager.Action = .click,
                  category: AnalyticsManager.Category,
                  product: AnalyticsManager.Product,
                  iconName: String? = nil,
                  color: UIColor? = nil,
                  position: Int? = nil,
                  type: AnalyticsManager.LogType,
                  header: String?,
                  linkType: AnalyticsManager.Linktype = .internalLink,
                  pageHeadline: String?,
                  next: AnalyticsManager.Next?) {
        let log = AnalyticsManager.Parameters(name: name.rawValue,
                                       action: action.rawValue,
                                       label: label,
                                       category: category.rawValue,
                                       product: product.name,
                                       iconName: iconName,
                                       color: color?.name,
                                       position: position,
                                       type: type.rawValue,
                                       header: header,
                                       linkType: linkType.rawValue,
                                       pageHeadline: pageHeadline,
                                       next: next?.destination)
        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
