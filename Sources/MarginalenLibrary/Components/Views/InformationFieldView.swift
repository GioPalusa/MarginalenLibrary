//
//  InformationFieldView.swift
//  Marginalen
//
//  Created by Giovanni Palusa on 2021-07-02.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct InformationFieldView<Destination: View>: View {
    let leadingTitle: String
    let trailingTitle: String?
    let leadingBody: String?
    let trailingBody: String?
    let leadingIcon: Icon?
    let destination: Destination
    private var centerTrailingTitle: Bool
    private var centerLeadingTitle: Bool

    init(leadingTitle: String,
         trailingTitle: String?,
         leadingBody: String?,
         trailingBody: String?,
         leadingIcon: Icon? = nil,
         centerTrailingTitle: Bool = false,
         centerLeadingTitle: Bool = false,
         destination: Destination) {
        self.leadingTitle = leadingTitle
        self.trailingTitle = trailingTitle
        self.leadingBody = leadingBody
        self.trailingBody = trailingBody
        self.leadingIcon = leadingIcon
        self.centerTrailingTitle = centerTrailingTitle
        self.centerLeadingTitle = centerLeadingTitle
        self.destination = destination
    }

    var upperPart: some View {
        HStack {
            Text(leadingTitle)
                .leadingAlignment()
                .offset(x: 0, y: centerLeadingTitle ? 15 : 0)
            if let trailingTitle = trailingTitle {
                Text(trailingTitle)
                    .trailingAlignment()
                    .offset(x: 0, y: centerTrailingTitle ? 15 : 0)
            }
        }
        .font(font: .title)
        .foregroundColor(.label)

    }

    var lowerPart: some View {
        HStack {
            Text(leadingBody ?? "")
                .leadingAlignment()
            if let body = trailingBody {
                Text(body)
                    .trailingAlignment()
            }
        }
        .font(font: .smallText)
        .foregroundColor(.label)
    }

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 8) {
                HStack(spacing: 8) {
                    if let icon = leadingIcon {
                        icon
                            .resizable()
                            .frame(width: 32, height: 32)
                    }

                    VStack {
                        upperPart
                        lowerPart
                    }
                }
                .padding(.leading, 16)

                Icon(.rightChevron)
                    .foregroundColor(.marginalen(color: .primaryRed))
                    .padding(.trailing, 8)
            }
            .frame(height: 88)
        }
    }
}

struct InformationFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InformationFieldView(leadingTitle: "Privatlån",
                       trailingTitle: "- 105 000,00",
                       leadingBody: "Amorterat 45 000,00",
                       trailingBody: nil,
                       destination: EmptyView())

            InformationFieldView(leadingTitle: "Transaktionstext",
                       trailingTitle: "32,00",
                       leadingBody: "Alternative text",
                       trailingBody: "2021-08-10",
                       destination: EmptyView())

            InformationFieldView(leadingTitle: "Transaktionstext",
                       trailingTitle: "32,00",
                       leadingBody: "Alternative text",
                       trailingBody: nil,
                       centerTrailingTitle: true,
                       destination: EmptyView())

            InformationFieldView(leadingTitle: "Privatlån",
                       trailingTitle: "- 105 000,00",
                       leadingBody: "Amorterat 45 000,00",
                       trailingBody: nil,
                       leadingIcon: Icon(.logo),
                       destination: EmptyView())

            InformationFieldView(leadingTitle: "Privatlån",
                       trailingTitle: "- 105 000,00",
                       leadingBody: "Amorterat 45 000,00",
                       trailingBody: nil,
                       leadingIcon: Icon(.logo),
                       centerTrailingTitle: true,
                       destination: EmptyView())

            InformationFieldView(leadingTitle: "Privatlån",
                                 trailingTitle: "- 105 000,00",
                                 leadingBody: nil,
                                 trailingBody: nil,
                                 leadingIcon: Icon(.logo),
                                 centerTrailingTitle: true,
                                 centerLeadingTitle: true,
                                 destination: EmptyView())

            InformationFieldView(leadingTitle: "Privatlån med förmånlig ränta",
                                 trailingTitle: nil,
                                 leadingBody: nil,
                                 trailingBody: nil,
                                 leadingIcon: Icon(.logo),
                                 centerLeadingTitle: true,
                                 destination: EmptyView())
        }
        .previewLayout(.fixed(width: 375, height: 88))
    }
}
