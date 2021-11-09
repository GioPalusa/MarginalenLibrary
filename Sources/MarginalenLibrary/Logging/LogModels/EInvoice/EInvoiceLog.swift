//
//  EInvoiceLog.swift
//  Marginalen
//
//  Created by michaelst on 2021-09-06.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import Foundation

struct EInvoiceLog: AnalyticsLog {
    var name: String?
    var type: String?
    var category: String?
    var product: String?
    var headline: String?
    var step: String?
    var invoiceCount: Int?
    var selectedInvoices: Int?
    var totalAmount: Double?
    var response: String?
    var unsignedCount: Int?
    var errorField: String?
    var place: String?

    enum EventType: String, Codable {
        case signedEInvoice = "signed_efaktura"
        case eInvoiceCheckout1 = "checkout_efaktura_1"
        case eInvoiceCheckout2 = "checkout_efaktura_2"
        case eInvoiceCheckoutCancel = "checkout_efaktura_cancelled"
        case eInvoiceAddNew = "add_new_efaktura"
        case eInvoiceAddNewError = "add_new_efaktura_error"
        case eInvoiceAddNewSigned = "add_new_efaktura_signed"
        case eInvoiceAddNewCancelled = "add_new_efaktura_cancelled"
        case eInvoiceAddNewHandle = "add_new_efaktura_handle"
        case eInvoiceAddNewHandled = "efaktura_handled"
        case payeeRemoved = "payee_removed"
        case payeeRemovedCancelled = "payee_removed_cancelled"
        case payeeAdd = "add_payee"
        case payeeAddComplete = "add_payee_complete"
        case payeeAddCancelled = "add_payee_cancelled"
        case eInvoiceImpression = "impression_efaktura"
    }

    enum CodingKeys: String, CodingKey {
        case name
        case category
        case headline
        case type

        case step = "Step"
        case invoiceCount = "count_invoice"
        case selectedInvoices = "selected_invoice"
        case totalAmount = "total_amount"
        case response
        case unsignedCount = "not_signed"
        case errorField = "error_field"
        case place
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(headline, forKey: .headline)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(step, forKey: .step)
        try container.encodeIfPresent(invoiceCount, forKey: .invoiceCount)
        try container.encodeIfPresent(selectedInvoices, forKey: .selectedInvoices)
        try container.encodeIfPresent(totalAmount, forKey: .totalAmount)
        try container.encodeIfPresent(response, forKey: .response)
        try container.encodeIfPresent(unsignedCount, forKey: .unsignedCount)
        try container.encodeIfPresent(errorField, forKey: .errorField)
        try container.encodeIfPresent(place, forKey: .place)
    }
}
