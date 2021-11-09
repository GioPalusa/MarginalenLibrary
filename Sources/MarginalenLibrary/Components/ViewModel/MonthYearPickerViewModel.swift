//
//  MonthYearPickerViewModel.swift
//  Marginalen
//
//  Created by michaelst on 2021-08-11.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

class MonthYearPickerViewModel: ObservableObject {
    @Published var selectedMonthYear = String()
    @Published var monthYearString = String()
    @Published var monthIndex: Int = -1
    @Published var yearIndex: Int = -1
    @Published var label = String()
    var selectableYears: [Int] = Array(Date().year - 50 ..< Date().year + 20)
    var selectedRow: Int = 0
    var currentRow: Int = 0

    let monthSymbols = Calendar.current.monthSymbols

    var currentMonthIndex: Int {
        return Date().month - 1
    }

    var currentYearIndex: Int {
        let index = selectableYears.firstIndex { $0 == Date().year }
        return index ?? 0
    }

    var monthYearAsDate: Date? {
        get {
            let year = selectableYears[safe: yearIndex]
            return Date.calendar.date(from: DateComponents(year: year, month: monthIndex + 1))
        }
        set(newValue) {
            guard let date = newValue else { return }
            monthIndex = date.month - 1
            yearIndex = selectableYears.firstIndex { $0 == date.year } ?? 0
        }
    }

    var monthYearAsShortDateString: String? {
        return String(monthYearAsDate?.toString().prefix(7) ?? "")
    }
}

extension MonthYearPickerViewModel {
    func logToAnalytics(category: AnalyticsManager.Category = .unknown,
                        product: AnalyticsManager.Product = .unknown,
                        header: String = "",
                        pageHeadline: String = "") {
        selectedRow = monthIndex + yearIndex
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
