//
//  AnalyticsManager+Next.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
    enum Next {
        case pageview(view: String)
        case webView(view: String)
        case appview(view: String)
        case position(newPosition: Int)
        case pdf(information: String)
        case popup(info: String?)
        case open(view: String?)
        case close, checked, unchecked, apply
        case custom(destination: String)

        var destination: String {
            switch self {
            case .pageview(let view): return "pageview_\(view)"
            case .webView(let view): return "webview_\(view)"
            case .appview(let view): return "appview_\(view)"
            case .pdf(let information): return "PDF_\(information)"
            case .open(let view):
                guard let view = view else { return "open" }
                return "open_\(view)"
            case .close: return "close"
            case .checked: return "checked"
            case .unchecked: return "unchecked"
            case .apply: return "apply"
            case .position(let position): return "position_\(position)"
            case .popup(let info):
                guard let info = info else { return "popup" }
                return "popup_\(info)"
            case .custom(let destination): return destination
            }
        }
    }
}
