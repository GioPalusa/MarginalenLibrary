//
//  AnalyticsParameters.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

protocol AnalyticsLog: Encodable {
    var name: String? { get set }
    var category: String? { get set }
    var product: String? { get set }
}
