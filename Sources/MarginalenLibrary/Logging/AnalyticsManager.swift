//
//  AnalyticsManager.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-11-16.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import FirebaseAnalytics
import UIKit

public class AnalyticsManager {

	static let shared = AnalyticsManager()

    func sendLog(log: Log) {
        let filteredLog = log.parameters.dictionary?.filter { $0.key != "name" }
        #if !DEBUG
        Analytics.logEvent(log.parameters.name ?? "", parameters: filteredLog)
        #elseif DEBUG
        Analytics.logEvent(log.parameters.name ?? "", parameters: filteredLog)
        LocalLogger.log(standard: "Interaction logging for: \(log.parameters.name ?? ""): \(filteredLog ?? [:])")
        #endif
    }

    func sendLog(with parameters: AnalyticsLog) {
        let filteredParameters = parameters.dictionary?.filter { $0.key != "name" }
        #if !DEBUG
        Analytics.logEvent(parameters.name ?? "", parameters: filteredParameters)
        #elseif DEBUG
        Analytics.logEvent(parameters.name ?? "", parameters: filteredParameters)
        LocalLogger.log(standard: "Logged: \(parameters.name ?? ""): \(filteredParameters ?? [:])")
        #endif
    }

    struct Log: Codable {
        var event: EventNameType = .interaction
        var parameters: Parameters
    }

    enum LogSubject: String, Codable {
        case cardTransaction = "crossBorder_transaction"
    }

    enum EventNameType: String, Codable {
        case pushNotification = "push_notis"
        case consent = "approve_offers"
        case interaction
        case personalInformation = "my_information"
        case privateMaskedData = "private"
    }

    enum Answer: String, Codable {
        case yes
        case nope = "no"
    }
}

extension AnalyticsManager {
    func log(event: EventNameType = .interaction,
                    name: Name = .list,
                    action: Action = .click,
                    label: String?,
                    category: Category,
                    product: Product?,
                    iconName: String? = nil,
                    color: UIColor? = nil,
                    position: Int? = nil,
                    type: LogType = .list,
                    linkType: Linktype? = .internalLink,
                    header: String? = nil,
                    pageHeadline: String? = nil,
                    next: Next?,
                    appOpen: Bool? = nil,
                    subject: LogSubject? = nil,
                    status: String? = nil) {
        let log = Parameters(name: name.rawValue,
                      action: action.rawValue,
                      label: label,
                      category: category.rawValue,
                      product: product?.name,
                      iconName: iconName,
                      color: color?.name,
                      position: position,
                      type: type.rawValue,
                      header: header,
                      linkType: linkType?.rawValue,
                      pageHeadline: pageHeadline,
                      next: next?.destination,
                      status: status,
                      subject: subject,
                      appOpen: appOpen)

        AnalyticsManager.sendLog(log: Log(event: event, parameters: log))
    }

    func logMenuSwap(position: Int, newPosition: Int, item: MainMenuItem) {
        log(event: .interaction,
            name: .icon,
            action: .drag,
            label: item.name,
            category: item.analyticsCategory,
            product: nil,
            iconName: item.menuIcon?.name,
            color: nil,
            position: position,
            type: .menu,
            linkType: .internalLink,
            header: nil,
            pageHeadline: nil,
            next: .position(newPosition: newPosition),
            appOpen: nil,
            subject: nil)
    }

    func logMFlex(event: MFlexLog.EventType,
                         type: LogType? = nil,
                         product: Product? = .mflex,
                         category: Category? = .creditcards,
                         step: String? = nil,
                         headline: String? = nil,
                         maxAmount: String? = nil,
                         changedInformation: Answer? = nil,
                         cancelReason: String? = nil,
                         viewModel: MFlexApplicationViewModel? = nil) {
        var updatedCustomerInformation: Answer?
        if let updatedInfo = viewModel?.updatedCustomerInformation {
            updatedCustomerInformation = updatedInfo ? .yes : .nope
        }

        var pep: Answer?
        if let unwrappedPep = viewModel?.pep {
            pep = unwrappedPep ? .yes : .nope
        }

        var appliedAmount: String?
        if let applied = viewModel?.appliedAmount {
            appliedAmount = String(applied)
        }

        var monthlyIncome: String?
        if let income = viewModel?.monthlyIncome {
            monthlyIncome = String(income)
        }

        let log = MFlexLog(name: event.rawValue,
                           type: type?.rawValue,
                           category: category?.rawValue,
                           product: product?.name,
                           headline: headline,
                           step: step,
                           accountSelection: viewModel?.accountSelection,
                           maxAmount: appliedAmount,
                           changedInformation: updatedCustomerInformation,
                           housingType: viewModel?.typeOfResidence?.asString(),
                           childrenAmount: viewModel?.numberOfChildren?.title,
                           civilStatus: viewModel?.civilStatus?.asString(),
                           employmentType: viewModel?.employment?.asString(),
                           hiredSince: viewModel?.employedSince?.stringFromDate(format: .yearMonthFull),
                           hiredTo: viewModel?.employedUntil?.stringFromDate(format: .yearMonthFull),
                           monthlySalary: monthlyIncome,
                           pep: pep,
                           reason: viewModel?.purpose?.asString(),
                           cancelReason: cancelReason)
        sendLog(with: log)
    }

    func logCreditLimitIncrease(event: CreditLimitIncreaseLog.EventType,
                                       type: LogType? = nil,
                                       product: String? = nil,
                                       category: Category? = .creditcards,
                                       label: String? = nil,
                                       headline: String? = nil,
                                       maxAmount: String? = nil,
                                       changedInformation: Answer? = nil,
                                       cancelReason: String? = nil,
                                       viewModel: CreditLimitApplicationVM? = nil) {

        var updatedCustomerInformation: Answer?
        if let updatedInfo = viewModel?.contactInfo.contactInfoViewModel.isUpdated {
            updatedCustomerInformation = updatedInfo ? .yes : .nope
        }
        var productName: String?
        if product == nil, let name = viewModel?.creditIncreaseInfo.card?.productName {
            productName = name
        } else {
            productName = product
        }
        var step: String?
        if let currentStep = viewModel?.currentStep {
            step = String(currentStep)
        }
        var header: String?
        if headline == nil, let title = viewModel?.currentStepTitle {
            header = title
        } else {
            header = headline
        }
        var maxAmount: String?
        if let amount = viewModel?.creditIncreaseInfo.getCreditLimit() {
            maxAmount = String(amount)
        }
        var currentAmount: String?
        if let amount = viewModel?.creditIncreaseInfo.currentCreditLimit {
            currentAmount = String(amount)
        }
        var selectedAmount: String?
        if let amount = viewModel?.creditIncreaseInfo.appliedCreditLimit {
            selectedAmount = String(amount)
        }
        var newAmount: String?
        if let amount = viewModel?.creditIncreaseInfo.newCreditLimit {
            newAmount = String(amount)
        }
        var monthlyIncome: String?
        if let amount = viewModel?.employmentInfo.monthlyIncome {
            monthlyIncome = String(amount)
        }
        var hiredSince: String?
        if let date = viewModel?.employmentInfo.employedSincePickerViewModel.monthYearAsShortDateString {
            hiredSince = date
        }
        var hiredTo: String?
        if let date = viewModel?.employmentInfo.employedUntilPickerViewModel.monthYearAsShortDateString {
            hiredTo = date
        }
        let log = CreditLimitIncreaseLog(name: event.rawValue,
                                         label: label,
                                         type: type?.rawValue,
                                         category: category?.rawValue,
                                         product: productName,
                                         headline: header,
                                         step: step,
                                         maxAmount: maxAmount,
                                         currentAmount: currentAmount,
                                         selectedAmount: selectedAmount,
                                         newAmount: newAmount,
                                         changedInformation: updatedCustomerInformation,
                                         employmentType: viewModel?.employmentInfo.employment,
                                         hiredSince: hiredSince,
                                         hiredTo: hiredTo,
                                         monthlySalary: monthlyIncome,
                                         cancelReason: cancelReason)
        sendLog(with: log)
    }
    func logEInvoice(event: EInvoiceLog.EventType,
                            type: LogType? = nil,
                            product: Product? = .eInvoice,
                            category: Category? = .payment,
                            step: String? = nil,
                            headline: String? = nil,
                            invoiceViewModel: EInvoiceViewModel? = nil,
                            detailInvoiceViewModel: DetailedInvoiceViewModel? = nil,
                            signSuccess: Bool? = nil,
                            errorField: String? = nil,
                            place: String? = nil) {

        var invoiceCount: Int?
        if let count = invoiceViewModel?.eInvoicesCount {
            invoiceCount = count
        }

        var selectedInvoices: Int?
        if let selected = invoiceViewModel?.selectedInvoices {
            selectedInvoices = selected.count
        }

        var totalAmount: Double?
        if let amount = invoiceViewModel?.selectedInvoices.compactMap({ $0.amount }).reduce(0, +) {
            totalAmount = amount
        } else if let amount = detailInvoiceViewModel?.originalTransfer.amount {
            totalAmount = amount
        }

        var response: String?
        if let success = signSuccess {
            response = success ? "complete" : "failed"
        }

        var failedInvoices: Int?
        if let count = invoiceViewModel?.currentFailCount, signSuccess == false {
            failedInvoices = count
        } else {
            failedInvoices = invoiceCount
        }

        let log = EInvoiceLog(name: event.rawValue,
                              type: type?.rawValue,
                              category: category?.rawValue,
                              product: product?.name,
                              headline: headline,
                              step: step,
                              invoiceCount: invoiceCount,
                              selectedInvoices: selectedInvoices,
                              totalAmount: totalAmount,
                              response: response,
                              unsignedCount: failedInvoices,
                              errorField: errorField,
                              place: place)
        sendLog(with: log)
    }
}
