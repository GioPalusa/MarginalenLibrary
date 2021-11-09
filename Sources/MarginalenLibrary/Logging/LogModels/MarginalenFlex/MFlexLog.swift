//
//  MFlexLog.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

struct MFlexLog: AnalyticsLog {
    var name: String?
    var type: String?
    var category: String?
    var product: String?
    var headline: String?
    var step: String?
    var accountSelection: String?
    var maxAmount: String?
    var changedInformation: AnalyticsManager.Answer?
    var housingType: String?
    var childrenAmount: String?
    var civilStatus: String?
    var employmentType: String?
    var hiredSince: String?
    var hiredTo: String?
    var monthlySalary: String?
    var pep: AnalyticsManager.Answer?
    var reason: String?
    var cancelReason: String?

    enum EventType: String, Codable {
        case mflexCheckout1 = "checkout_marginalen_flex_1"
        case mflexCheckout2 = "checkout_marginalen_flex_2"
        case mflexCheckout3 = "checkout_marginalen_flex_3"
        case mflexCheckout4 = "checkout_marginalen_flex_4"
        case mflexCheckout5 = "checkout_marginalen_flex_5"
        case mflexCheckout6 = "checkout_marginalen_flex_6"
        case mflexCheckout7 = "checkout_marginalen_flex_7"
        case purchase = "purchase_marginalen_flex"
        case impression = "impression_marginalen_flex"
        case onboarding = "onboarding_marginalen_flex"
        case productView = "product_view_marginalen_flex"
        case cancel = "checkout_marginalen_flex_cancel"
    }

    enum CodingKeys: String, CodingKey {
        case name
        case category
        case product = "Marginalen Flex"
        case headline
        case type

        case step = "Step"
        case accountSelection = "account_selection"
        case maxAmount = "max_amount"
        case changedInformation = "changed_information"
        case housingType = "housing_type"
        case childrenAmount = "amount_children"
        case civilStatus = "marital_status"
        case employmentType = "employment_type"
        case hiredSince = "hired_since"
        case hiredTo = "hired_to"
        case monthlySalary = "monthly_salary"
        case pep
        case reason
        case cancelReason = "reason_cancel"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(headline, forKey: .headline)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(product, forKey: .product)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(accountSelection, forKey: .accountSelection)
        try container.encodeIfPresent(maxAmount, forKey: .maxAmount)
        try container.encodeIfPresent(changedInformation, forKey: .changedInformation)
        try container.encodeIfPresent(housingType, forKey: .housingType)
        try container.encodeIfPresent(childrenAmount, forKey: .childrenAmount)
        try container.encodeIfPresent(civilStatus, forKey: .civilStatus)
        try container.encodeIfPresent(employmentType, forKey: .employmentType)
        try container.encodeIfPresent(hiredSince, forKey: .hiredSince)
        try container.encodeIfPresent(hiredTo, forKey: .hiredTo)
        try container.encodeIfPresent(monthlySalary, forKey: .monthlySalary)
        try container.encodeIfPresent(pep, forKey: .pep)
        try container.encodeIfPresent(reason, forKey: .reason)
        try container.encodeIfPresent(cancelReason, forKey: .cancelReason)
    }
}
