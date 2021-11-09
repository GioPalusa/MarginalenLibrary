//
//  Date+extensions.swift
//  Marginalen
//
//  Created by Denis Leal on 2019-05-13.
//  Copyright © 2019 Marginalen Bank. All rights reserved.
//

import Foundation

extension Date {
    static var yesterday: Date {
        return swedishDate.dayBefore
    }

    static var tomorrow: Date {
        return swedishDate.dayAfter
    }

    static var swedishDate: Date {
        guard let ntpTime = timeClient.referenceTime?.now() else { return Date() }
        return ntpTime
    }

    static var calendar: Calendar = {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "CET")!
        return calendar
    }()

    static func getDate(in days: Int) -> Date {
        var date = Date.swedishDate
        date.changeDays(by: days)
        return date
    }

    var dayBefore: Date {
        return Date.calendar.date(byAdding: .day, value: -1, to: noon)!
    }

    var dayAfter: Date {
        return Date.calendar.date(byAdding: .day, value: 1, to: noon)!
    }

    var noon: Date {
        return Date.calendar.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var month: Int {
        return Date.calendar.component(.month, from: self)
    }

    var year: Int {
        return Date.calendar.component(.year, from: self)
    }

    var day: Int {
        return Date.calendar.component(.day, from: self)
    }

    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }

    var isToday: Bool {
        return Date.calendar.isDateInToday(self)
    }

    var isTomorrow: Bool {
        return Date.calendar.isDateInTomorrow(self)
    }

    var isWeekend: Bool {
        return Date.calendar.isDateInWeekend(self)
    }

    func isSameDay(as date: Date) -> Bool {
        return Date.calendar.isDate(self, inSameDayAs: date)
    }

    mutating func changeDays(by days: Int) {
        self = Date.calendar.date(byAdding: .day, value: days, to: self)!
    }

    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Date.calendar.dateComponents([.second], from: date, to: self).second ?? 0
    }

    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Date.calendar.dateComponents([.minute], from: date, to: self).minute ?? 0
    }

    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Date.calendar.dateComponents([.hour], from: date, to: self).hour ?? 0
    }

    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Date.calendar.dateComponents([.day], from: date, to: self).day ?? 0
    }

    func isALaterDate(comparedTo date: Date) -> Bool {
        if case .orderedDescending = self.compare(date) {
            return true
        } else {
            return false
        }
    }

    /// Different types of date formats for presenting dates
    enum DateFormat {
        /// Dateformatted as `yyyy-MM-DD`
        case yearMonthDayFull
        /// Dateformatted as `yyyy-MM`
        case yearMonthFull
        /// Dateformatted as `yy-MM-dd`
        case yearMonthDayShort
        /// Dateformatted as `yyMMdd`
        case yearMonthDayShortNoDash
        /// Dateformatted as `MMMM YYYYY`
        case monthNameYear
        /// Dateformatted as `dd MMMM YYYY`
        case dateMonthFullNameYear
        /// Dateformatted as `dd/MM`
        case monthDay
        /// Dateformatted as `dd`
        case day
        /// Dateformatted as `MMMM`
        case monthName
        /// Dateformatted as `yyyy-MM-dd HH:mm:ss`
        case yearMonthDayHourMinutesSeconds
        /// Dateformatted as `yyyy-MM-dd'T'HH:mm:ss`
        case yearMonthDayTHourMinutesSeconds
        /// Dateformatted as `yyyy-MM-dd HH:mm`
        case yearMonthDayHourMinutes
        /// Dateformatted as `dddd`
        case weekdayName
        /// Dateformatted as the custom string format entered
        /// - format: String that needs to have a correct date format, like `YYYY-MM-DD`
        case custom(format: String)
        case `default`

        var value: String {
            switch self {
            case .yearMonthDayFull: return "yyyy-MM-dd"
            case .yearMonthFull: return "yyyy-MM"
            case .yearMonthDayShort: return "yy-MM-dd"
            case .yearMonthDayShortNoDash: return "yyMMdd"
            case .dateMonthFullNameYear: return "dd MMMM YYYY"
            case .monthDay: return "dd/MM"
            case .day: return "dd"
            case .monthName: return "MMMM"
            case .monthNameYear: return "MMMM yyyy"
            case .yearMonthDayHourMinutesSeconds: return "yyyy-MM-dd HH:mm:ss"
            case .yearMonthDayTHourMinutesSeconds: return "yyyy-MM-dd'T'HH:mm:ss"
            case .yearMonthDayHourMinutes: return "yyyy-MM-dd HH:mm"
            case .weekdayName: return "dddd"
            case .custom(let customFormat): return customFormat
            case .default: return "yyyy-MM-dd HH:mm:ss"
            }
        }
    }

    /// Returns a string with a formatted type. Standard is `yyyy-MM-dd HH:mm:ss`
    /// - Parameter format: optional Dateformat from enum to return another type of formatted string
    func stringFromDate(format: DateFormat = .default) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.value
        return formatter.string(from: self)
    }

    func toString() -> String {
        return ISO8601DateFormatter().string(from: self)
    }

    func toShortDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
