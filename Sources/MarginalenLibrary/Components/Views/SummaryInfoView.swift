//
//  SummaryInfoView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-04.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - SummaryInfoView

struct SummaryInfoView: View {
    var label: String
    var font: Font.Marginalen = .regularTitle
    var headerPaddingSize: Size = .regular
    var button: DiscreteButton
    var values: [[SummaryValues]] = []
    var buttonIsHidden: Bool = false
    var ignorePadding: Bool = false

    enum Size {
        case regular, small
    }

    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(font: font)
                Spacer()
                button
                    .hidden(buttonIsHidden)
            }
            .foregroundColor(Color(UIColor.MarginalenColors.primaryRed.color))
            .padding(.bottom, headerPaddingSize == .regular ? 32 : 16)
            .padding(.horizontal, 16)

            if !values.isEmpty {
                VStack {
                    ForEach(values, id: \.self) { strings in
                        ForEach(strings) { string in
                            InfoLine(info: .init(titleLeft: string.leftValue,
                                                 titleRight: string.rightValue))
                                .padding(.bottom, 16)
                        }
                    }
                }
                .padding(.bottom, ignorePadding ? 0 : 16)
            }
        }
        .padding(.top, headerPaddingSize == .regular ? 32 : 16)
        .background(Color(UIColor.secondarySystemGroupedBackground))
    }
}

// MARK: - SummaryValues

struct SummaryValues: Identifiable, Hashable {
    var id = UUID()
    let leftValue: String
    let rightValue: String
}

// MARK: - SummaryInfoView_Previews

struct SummaryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryInfoView(label: "Huvudrubrik", button: DiscreteButton(text: "Ändra", action: {}), values: [[SummaryValues(leftValue: "Rubrik1", rightValue: "Värde1"), SummaryValues(leftValue: "Rubrik2", rightValue: "Värde2")]])
    }
}
