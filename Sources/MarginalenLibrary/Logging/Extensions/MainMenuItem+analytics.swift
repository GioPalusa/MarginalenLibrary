//
//  MainMenuItem+analytics.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-11-27.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import UIKit

extension MainMenuItem {

    /// Adds logging to a menu item
    /// - Parameters:
    ///   - position: Position of the icon, bottom bar has position 1,2 or 3
    ///   - type: `nav_bar` or `menu`
    func logClick(position: Int,
                  type: AnalyticsManager.LogType) {

        let log = AnalyticsManager.Parameters(name: AnalyticsManager.Name.icon.rawValue,
                                              action: AnalyticsManager.Action.click.rawValue,
                                              label: self.name,
                                              category: nil,
                                              product: nil,
                                              iconName: self.menuIcon?.name,
                                              color: nil,
                                              position: position,
                                              type: type.rawValue,
                                              header: nil,
                                              linkType: nil,
                                              pageHeadline: nil,
                                              next: AnalyticsManager.Next.pageview(view: analyticsTitle ?? "n/a").destination)
        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
