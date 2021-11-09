//
//  LocalLogger.swift
//  Marginalen
//
//  Created by Giovanni on 2020-12-14.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import os.log
import Foundation

// swiftlint:disable identifier_name
public class LocalLogger {

    // Function for public logging
    static func log(UI: String) {
        os_log("%@", log: .ui, type: .debug, UI)
    }

    static func log(network: String) {
        os_log("%@", log: .network, type: .debug, network)
    }

    static func log(standard: String) {
        os_log("%@", log: .standard, type: .default, standard)
    }

    static func log(error: String) {
        os_log("%@", log: .standard, type: .error, error)
    }

    // Functions for private logging
    static func log(privateUI: String, logMessage: String) {
        os_log("%@ %{PRIVATE}@", log: .ui, type: .debug, logMessage, privateUI)
    }

    static func log(privateNetwork: String, logMessage: String) {
        os_log("%@ %{PRIVATE}@", log: .network, type: .debug, logMessage, privateNetwork)
    }

    static func log(privateDefault: String, logMessage: String) {
        os_log("%@ %{PRIVATE}@", log: .standard, type: .default, logMessage, privateDefault)
    }
}

extension OSLog {
    private static var subsystem = bundleID
    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let standard = OSLog(subsystem: subsystem, category: "Standard")
}
