//
//  UIButton+analytics.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-11-27.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import UIKit

extension UIButton {
    /// Logging a click on a button
    /// - Parameters:
    ///   - name: Product name
    ///   - category: Product category
    ///   - position: Position of the button. Defaults is `nil`
    ///   - product: Specified product
    ///   - destination: Where the link/button takes you to
    ///   - product: Specified product
    ///   - iconName: Name of the icon asset. Default is `nil` and tries to retrieve the name from the asset inside the button
    ///   - type: Apperance or function
    func logClick(name: AnalyticsManager.Name = .button,
                  category: AnalyticsManager.Category,
                  color: UIColor? = nil,
                  position: Int? = nil,
                  next: AnalyticsManager.Next?,
                  product: AnalyticsManager.Product,
                  label: String? = nil,
                  iconName: String? = nil,
                  linkType: AnalyticsManager.Linktype = .internalLink,
                  header: String? = nil,
                  pageHeadline: String? = nil,
                  type: AnalyticsManager.LogType? = .rectangle) {
        let iconFullName = iconName == nil ? self.imageView?.image?.name : iconName
        let updatedPageHeadline = pageHeadline == nil ? self.parentViewControllerTitle : pageHeadline
        let backgroundColor = color != nil ? color?.name : color == nil ? self.backgroundColor?.name : nil

        let log = AnalyticsManager.Parameters(name: name.rawValue,
                                       action: AnalyticsManager.Action.click.rawValue,
                                       label: label ?? self.titleLabel?.text,
                                       category: category.rawValue,
                                       product: product.name, iconName: iconFullName,
                                       color: backgroundColor,
                                       position: position,
                                       type: type?.rawValue,
                                       header: header,
                                       linkType: linkType.rawValue,
                                       pageHeadline: updatedPageHeadline,
                                       next: next?.destination)

        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }

}

extension UIBarButtonItem {
    /// Logging a click on a button
    /// - Parameters:
    ///   - category: Product category
    ///   - position: Position of the button. Defaults to `0`
    ///   - product: Specified product
    ///   - destination: Where the link/button takes you to
    ///   - product: Specified product
    ///   - iconName: Name of the icon asset. Default is `nil` and tries to retrieve the name from the asset inside the button
    ///   - type: Apperance or function
    func logClick(category: AnalyticsManager.Category,
                  position: Int = 0,
                  next: AnalyticsManager.Next?,
                  product: AnalyticsManager.Product,
                  label: String? = nil,
                  iconName: String? = nil,
                  pageHeadline: String? = nil,
                  type: AnalyticsManager.LogType = .menu) {
        let iconFullName = iconName == nil ? self.image?.name : iconName

        let log = AnalyticsManager.Parameters(name: AnalyticsManager.Name.button.rawValue,
                                       action: AnalyticsManager.Action.click.rawValue,
                                       label: nil,
                                       category: category.rawValue,
                                       product: product.name, iconName: iconFullName,
                                       color: nil,
                                       position: position,
                                       type: type.rawValue,
                                       header: nil,
                                       linkType: nil,
                                       pageHeadline: nil,
                                       next: next?.destination)

        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
