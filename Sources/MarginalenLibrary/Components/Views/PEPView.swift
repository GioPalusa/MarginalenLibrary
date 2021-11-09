//
//  PEPView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-09-14.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct PEPView: View {
    let title: String
    @Binding var selection: DefaultSelectionButtonData?
    var yesAction: (() -> Void)?
    var noAction: (() -> Void)?
    var informationAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Divider().frame(height: 1)

            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(font: .smallText)
                    .fixedSize(horizontal: false, vertical: true)
                HStack(spacing: 24) {
                    SelectionButton(buttonMetaData: DefaultSelectionButtonData.yes,
                                    selectedButton: $selection,
                                    width: 110,
                                    action: yesAction ?? {})
                    SelectionButton(buttonMetaData: DefaultSelectionButtonData.nope,
                                    selectedButton: $selection,
                                    width: 110,
                                    action: noAction ?? {})

                    Button(action: informationAction, label: {
                        Icon(.info, isResizable: true)
                            .frame(width: 24, height: 24)
                    })
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 32)
        .background(Color.secondarySystemGroupedBackground)
    }
}

struct PEPView_Previews: PreviewProvider {
    static var previews: some View {
        PEPView(title: "Är du själv en person i politiskt utsatt ställning (PEP) eller är du anhörig eller nära medarbetare till någon som är det?",
                selection: .constant(nil),
                informationAction: {})
    }
}
