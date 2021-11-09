//
//  UIDevice+extensions.swift
//  Marginalen
//
//  Created by Denis Leal on 2019-03-06.
//  Copyright © 2019 Marginalen Bank. All rights reserved.
//

import UIKit

extension UIDevice {
    /// Checks if the screen size is of iPhone SE size
    /// - Returns: Bool value to handle if screen size is small.
    var isSmall: Bool {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let screenMaxLength = max(screenWidth, screenHeight)
        return userInterfaceIdiom == .phone && screenMaxLength <= 568.0
    }

    var deviceID: String {
        return self.identifierForVendor?.uuidString ?? ""
    }
}
