//
//  PickerFieldViewModel.swift
//  Marginalen
//
//  Created by michaelst on 2021-08-30.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

class PickerFieldViewModel: ObservableObject {
    @Published var currentRow = 0
    @Published var selectedRow = 0
    @Published var label = String()
    var values = [String]()
    var defaultValue = String()
}

extension PickerFieldViewModel {
    func logToAnalytics(category: AnalyticsManager.Category = .unknown,
                        product: AnalyticsManager.Product = .unknown,
                        header: String = "",
                        pageHeadline: String = "") {
        if currentRow != selectedRow {
            let direction = selectedRow < currentRow ? AnalyticsManager.Direction.up.rawValue : AnalyticsManager.Direction.down.rawValue
            let fromPosition = currentRow + 1
            AnalyticsManager.log(event: AnalyticsManager.EventNameType.interaction,
                                 name: AnalyticsManager.Name.slider,
                                 action: AnalyticsManager.Action.swipe,
                                 label: direction,
                                 category: category,
                                 product: product,
                                 iconName: nil,
                                 color: nil,
                                 position: fromPosition,
                                 type: AnalyticsManager.LogType.slider,
                                 linkType: nil,
                                 header: header,
                                 pageHeadline: pageHeadline,
                                 next: nil)
            currentRow = selectedRow
        }
    }
}
