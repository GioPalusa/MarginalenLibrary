//
//  Event+analytics.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2020-11-30.
//  Copyright © 2020 Marginalen Bank. All rights reserved.
//

import UIKit

extension OverviewEventView {
    func logClick(in position: Int, header: String) {
        var category: AnalyticsManager.Category = .unknown
        var product: AnalyticsManager.Product = .unknown
        var next: String

        switch self.event.type {
        case .payment, .eInvoice, .eppTransaction:
            category = .digital
            product = .betalaOverfor
            next = EventsViewController.title
        case .cardActivation(let card):
            category = .creditcards
            product = .productname(name: card.productName)
            next = CardDetailVC.title
        case .creditLimitIncrease(let application):
            category = .creditcards
            product = .productname(name: application.applicationTypeCode.rawValue)
            next = CardDetailVC.title
        case .creditAccountMissedPayment:
            category = .creditAccount
            product = .mflex
            next = MFlexOverviewViewController.title
        case .loanInsolvency:
            category = .loans
            product = .productname(name: "Lån")
            next = LoanHostingController.title
        }

        let log = AnalyticsManager.Parameters(name: AnalyticsManager.Name.handelserCard.rawValue,
                                       action: AnalyticsManager.Action.click.rawValue,
                                       label: self.descriptionLabel.text,
                                       category: category.rawValue,
                                       product: product.name,
                                       iconName: self.imageView.image?.name,
                                       color: nil,
                                       position: position,
                                       type: AnalyticsManager.LogType.carousel.rawValue,
                                       header: header,
                                       linkType: AnalyticsManager.Linktype.internalLink.rawValue,
                                       pageHeadline: "Översikt",
                                       next: AnalyticsManager.Next.pageview(view: next).destination)

        AnalyticsManager.sendLog(log: AnalyticsManager.Log(parameters: log))
    }
}
