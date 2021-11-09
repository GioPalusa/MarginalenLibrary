//
//  LoggingManager.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-11-16.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import UIKit
import FirebaseAnalytics

public class LoggingManager {

    static func sendLog(log: AnalyticsLog) {
        #if !DEBUG
        Analytics.logEvent("interaction", parameters: log.dictionary)
        #endif
    }

	public class AnalyticsLog: Codable {
        var name: String
        var action: String
        var label: String?
        var category: String?
        var product: String?
        var iconName: String?
        var color: String?
        var position: Int
        var type: String?
        var header: String?
        var linkType: String?
        var pageHeadline: String?
        var next: String?

        init(name: String, action: String, label: String?,
             category: String?, product: String?, iconName: String?,
             color: String?, position: Int, type: String?,
             header: String?, linkType: String?,
             pageHeadline: String?, next: String?) {
            self.name = name
            self.action = action
            self.label = label
            self.category = category
            self.product = iconName
            self.iconName = iconName
            self.color = color
            self.position = position
            self.type = type
            self.header = header
            self.linkType = linkType
            self.pageHeadline = pageHeadline
            self.next = next
        }
    }

	public enum AnalyticsLinktype: String, Codable {
        case internalLink = "Internal"
        case external = "External"
        case pdf = "PDF"
        case toggle = "Toggle"
    }

    public enum AnalyticsCategory: String, Codable {
        case accounts = "Konton"
        case creditcards = "Kreditkort och Bankkort"
        case digital = "Digitala tjänster"
        case loans = "Låna"
        case unknown
    }

    public enum AnalyticsProduct: Codable {
        case sparande
        case lonekonto
        case fastrantekonto
        case hograntekonto
        case swish
        case meddelande
        case betalaOverfor
        case productname(name: String?)
        case unknown

        var name: String {
            switch self {
            case .sparande: return "sparande"
            case .lonekonto: return "lönekonto"
            case .fastrantekonto: return "fasträntekonto"
            case .hograntekonto: return "högräntekonto"
            case .swish: return "swish"
            case .meddelande: return "meddelande"
            case .betalaOverfor: return "Betala och överför"
            case .productname(let name): return "\(name ?? "unknown")"
            case .unknown: return "unknown"
            }
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let name = try container.decode(String.self)

            switch name {
            case "sparande": self = .sparande
            case "lönekonto": self = .lonekonto
            case "fasträntekonto": self = .fastrantekonto
            case "högräntekonto": self = .hograntekonto
            case "swish": self = .swish
            case "meddelande": self = .meddelande
            case "Betala och överför": self = .betalaOverfor
            case "unknown": self = .unknown
            default: self = .productname(name: name)
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .sparande: try container.encode(0)
            case .lonekonto: try container.encode(1)
            case .fastrantekonto: try container.encode(2)
            case .hograntekonto: try container.encode(3)
            case .swish: try container.encode(4)
            case .meddelande: try container.encode(5)
            case .betalaOverfor: try container.encode(6)
            case .productname(let name): try container.encode(name)
            case .unknown: try container.encode(8)
            }
        }
    }

    public enum AnalyticsName: String, Codable {
        case pageSwipe = "page_swipe"
        case slider
        case icon
        case button
        case tab
        case input
        case handelserCard = "handelser_card"
        case picker
        case checkbox
    }

    public enum AnalyticsLogType: String, Codable {
        case circle
        case switchbtn = "switch_button"
        case rectangle
        case header
        case menu
        case calendar
        case pickerlist = "picker_list"
        case navbar = "nav_bar"
        case popup = "pop-up"
        case slider
        case select
        case text
        case search
        case list
        case square
        case carousel
        case sliderAmount = "slider_amount"
        case datepicker = "date_picker"
    }

    public enum AnalyticsLogAction: String, Codable {
        case swipe
        case drag
        case click
    }
}

extension LoggingManager {

    public func logMenuSwap(position: Int, newPosition: Int, item: MainMenuItem) {
        let log = LoggingManager.AnalyticsLog(name: "icon",
                                              action: LoggingManager.AnalyticsLogAction.drag.rawValue,
                                              label: item.name,
                                              category: LoggingManager.AnalyticsCategory.unknown.rawValue,
                                              product: nil,
                                              iconName: item.menuIcon?.name,
                                              color: nil,
                                              position: position,
                                              type: LoggingManager.AnalyticsLogType.menu.rawValue,
                                              header: nil,
                                              linkType: LoggingManager.AnalyticsLinktype.internalLink.rawValue,
                                              pageHeadline: nil,
                                              next: "position_\(newPosition)")

        LoggingManager.sendLog(log: log)
    }
}
