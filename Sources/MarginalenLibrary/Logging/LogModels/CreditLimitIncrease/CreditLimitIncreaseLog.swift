//
//  CreditLimitIncreaseLog.swift
//  Marginalen
//
//  Created by michaelst on 2021-08-27.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

struct CreditLimitIncreaseLog: AnalyticsLog {
    var name: String?
    var label: String?
    var type: String?
    var category: String?
    var product: String?
    var headline: String?
    var step: String?
    var maxAmount: String?
    var currentAmount: String?
    var selectedAmount: String?
    var newAmount: String?
    var changedInformation: AnalyticsManager.Answer?
    var employmentType: String?
    var hiredSince: String?
    var hiredTo: String?
    var monthlySalary: String?
    var cancelReason: String?

    enum EventType: String, Codable {
        case creditIncreaseCheckout1 = "checkout_credit_increase_1"
        case creditIncreaseCheckout2 = "checkout_credit_increase_2"
        case creditIncreaseCheckout3 = "checkout_credit_increase_3"
        case creditIncreaseCheckout4 = "checkout_credit_increase_4"
        case impression = "impression_credit_increase"
        case cancel = "checkout_credit_increase_cancel"
    }

    enum CodingKeys: String, CodingKey {
        case name
        case category = "Kreditkort och Bankkort"
        case product
        case headline
        case type
        case label

        case step = "Step"
        case maxAmount = "max_amount"
        case selectedAmount = "selected_amount"
        case currentAmount = "current_amount"
        case newAmount = "new_amount"
        case changedInformation = "changed_information"
        case employmentType = "employment_type"
        case hiredSince = "hired_since"
        case hiredTo = "hired_to"
        case monthlySalary = "monthly_salary"
        case cancelReason = "reason_cancel"
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(headline, forKey: .headline)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(label, forKey: .label)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(product, forKey: .product)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(maxAmount, forKey: .maxAmount)
        try container.encodeIfPresent(selectedAmount, forKey: .selectedAmount)
        try container.encodeIfPresent(currentAmount, forKey: .currentAmount)
        try container.encodeIfPresent(newAmount, forKey: .newAmount)
        try container.encodeIfPresent(changedInformation, forKey: .changedInformation)
        try container.encodeIfPresent(employmentType, forKey: .employmentType)
        try container.encodeIfPresent(hiredSince, forKey: .hiredSince)
        try container.encodeIfPresent(hiredTo, forKey: .hiredTo)
        try container.encodeIfPresent(monthlySalary, forKey: .monthlySalary)
        try container.encodeIfPresent(cancelReason, forKey: .cancelReason)
    }
}
