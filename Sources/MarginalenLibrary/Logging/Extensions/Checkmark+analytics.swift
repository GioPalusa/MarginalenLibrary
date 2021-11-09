//
//  Checkmark+analytics.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-01-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension Checkmark {
    func log(isSelected: Bool,
             label: String? = nil,
             category: AnalyticsManager.Category = .digital,
             product: AnalyticsManager.Product,
             position: Int? = nil,
             type: AnalyticsManager.LogType = .pickerlist,
             header: String?,
             pageHeadline: String? = nil) {
        let updatedPageHeadline = pageHeadline == nil ? self.parentViewControllerTitle : pageHeadline

        let log = AnalyticsManager.Parameters(name: AnalyticsManager.Name.checkbox.rawValue,
                                       action: "click",
                                       label: label,
                                       category: category.rawValue,
                                       product: product.name,
                                       iconName: nil,
                                       color: nil,
                                       position: position,
                                       type: type.rawValue,
                                       header: header,
                                       linkType: nil,
                                       pageHeadline: updatedPageHeadline,
                                       next: isSelected ? AnalyticsManager.Next.checked.destination : AnalyticsManager.Next.unchecked.destination)
        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
