//
//  UISwitch+analytics.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-12-11.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import UIKit

extension UISwitch {
    func logChange(category: AnalyticsManager.Category, product: AnalyticsManager.Product, position: Int? = nil, label: String?, header: String? = nil) {
        AnalyticsManager.log(name: .button,
                             action: .click,
                             label: label,
                             category: category,
                             product: product,
                             iconName: nil,
                             color: nil,
                             position: position,
                             type: .switch,
                             linkType: .toggle,
                             header: header,
                             pageHeadline: parentViewControllerTitle,
                             next: isOn ? .open(view: nil) : .close)
    }
}
