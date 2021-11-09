//
//  UITextfield+analytics.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-12-07.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import UIKit

extension UITextField {

    func logClick(label: String?,
                  category: AnalyticsManager.Category = .digital,
                  product: AnalyticsManager.Product,
                  position: Int? = nil,
                  type: AnalyticsManager.LogType = .text,
                  header: String? = nil,
                  pageHeadline: String? = nil,
                  next: AnalyticsManager.Next?) {

        let headline = pageHeadline == nil ? self.parentViewControllerTitle : pageHeadline

        let log = AnalyticsManager.Parameters(name: AnalyticsManager.Name.input.rawValue,
                                              action: AnalyticsManager.Action.click.rawValue,
                                              label: label,
                                              category: category.rawValue,
                                              product: product.name,
                                              iconName: nil,
                                              color: nil,
                                              position: position,
                                              type: type.rawValue,
                                              header: header,
                                              linkType: nil,
                                              pageHeadline: headline,
                                              next: next?.destination)

        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
