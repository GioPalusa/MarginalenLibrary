//
//  AnalyticsManager+Parameters.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-18.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

extension AnalyticsManager {
	public struct Parameters: AnalyticsLog, Codable {
        var name: String?
        var action: String
        var label: String?
        var category: String?
        var product: String?
        var iconName: String?
        var color: String?
        var position: Int?
        var type: String?
        var header: String?
        var linkType: String?
        var pageHeadline: String?
        var next: String?
        var status: String?

        // Push specific
        var subject: LogSubject?
        var appOpen: Bool?

        // Marginalen Flex
        var step: String?
        var accountSelection: String?
        var maxAmount: String?
        var changedInformation: String?
        var housingType: String?
        var childrenAmount: String?
        var maritalStatus: String?
        var employmentType: String?
        var hiredSince: String?
        var hiredTo: String?
        var monthlySalary: String?
        var pep: String?
        var reason: String?

        enum CodingKeys: String, CodingKey {
            case name
            case action
            case label
            case category
            case product
            case iconName = "icon_name"
            case color
            case type
            case header
            case linkType = "link_type"
            case pageHeadline = "page_headline"
            case next
            case position
            case subject
            case appOpen = "app_open"
            case status

            case step = "Step"
            case accountSelection = "account_selection"
            case maxAmount = "max_amount"
            case changedInformation = "changed_information"
            case housingType = "housing_type"
            case childrenAmount = "amount_children"
            case maritalStatus = "marital_status"
            case employmentType = "employment_type"
            case hiredSince = "hired_since"
            case hiredTo = "hired_to"
            case monthlySalary = "monthly_salary"
            case pep
            case reason
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: .name)
            try container.encodeIfPresent(action, forKey: .action)
            try container.encodeIfPresent(label, forKey: .label)
            try container.encodeIfPresent(category, forKey: .category)
            try container.encodeIfPresent(product, forKey: .product)
            try container.encodeIfPresent(iconName, forKey: .iconName)
            try container.encodeIfPresent(color, forKey: .color)
            try container.encodeIfPresent(position, forKey: .position)
            try container.encodeIfPresent(type, forKey: .type)
            try container.encodeIfPresent(header, forKey: .header)
            try container.encodeIfPresent(linkType, forKey: .linkType)
            try container.encodeIfPresent(pageHeadline, forKey: .pageHeadline)
            try container.encodeIfPresent(next, forKey: .next)
            try container.encodeIfPresent(subject, forKey: .subject)
            try container.encodeIfPresent(appOpen, forKey: .appOpen)
            try container.encodeIfPresent(status, forKey: .status)
            try container.encodeIfPresent(step, forKey: .step)
            try container.encodeIfPresent(accountSelection, forKey: .accountSelection)
            try container.encodeIfPresent(maxAmount, forKey: .maxAmount)
            try container.encodeIfPresent(changedInformation, forKey: .changedInformation)
            try container.encodeIfPresent(housingType, forKey: .housingType)
            try container.encodeIfPresent(childrenAmount, forKey: .childrenAmount)
            try container.encodeIfPresent(maritalStatus, forKey: .maritalStatus)
            try container.encodeIfPresent(employmentType, forKey: .employmentType)
            try container.encodeIfPresent(hiredSince, forKey: .hiredSince)
            try container.encodeIfPresent(hiredTo, forKey: .hiredTo)
            try container.encodeIfPresent(monthlySalary, forKey: .monthlySalary)
            try container.encodeIfPresent(pep, forKey: .pep)
            try container.encodeIfPresent(reason, forKey: .reason)
        }
    }
}
