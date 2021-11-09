//
//  MonthYearPicker+analytics.swift
//  Marginalen
//
//  Created by michaelst on 2021-08-27.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension MonthYearPickerFieldView {
    func log(direction: AnalyticsManager.Direction,
             category: AnalyticsManager.Category,
             product: AnalyticsManager.Product,
             type: AnalyticsManager.LogType = .slider,
             fromPosition: Int,
             pageHeadline: String?) {
        AnalyticsManager.log(event: .interaction,
                             name: .slider,
                             action: .swipe,
                             label: direction.rawValue,
                             category: category,
                             product: product,
                             iconName: nil,
                             color: nil,
                             position: fromPosition,
                             type: type,
                             linkType: nil,
                             header: viewModel.label,
                             pageHeadline: pageHeadline,
                             next: nil)
    }
}
