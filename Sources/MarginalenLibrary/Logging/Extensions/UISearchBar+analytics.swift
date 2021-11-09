//
//  UISearchBar+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-02-04.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import UIKit

extension UISearchBar {
    func log(name: AnalyticsManager.Name = .input,
             action: AnalyticsManager.Action = .click,
             category: AnalyticsManager.Category,
             product: AnalyticsManager.Product,
             position: Int? = nil,
             type: AnalyticsManager.LogType = .search,
             header: String?,
             pageHeadline: String?) {

        let log = AnalyticsManager.Parameters(name: name.rawValue,
                                       action: action.rawValue,
                                       label: placeholder,
                                       category: category.rawValue,
                                       product: product.name,
                                       iconName: nil,
                                       color: nil,
                                       position: position,
                                       type: type.rawValue,
                                       header: header,
                                       linkType: nil,
                                       pageHeadline: pageHeadline,
                                       next: nil)
        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
