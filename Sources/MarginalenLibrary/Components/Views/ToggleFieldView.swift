//
//  ToggleFieldView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-04.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - ToggleFieldView

struct ToggleFieldView: View {
    var label: String
    @Binding var isOn: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(label)
                    .font(font: .title)
                    .foregroundColor(Color(UIColor.label))
                    .frame(height: 20)
                    .layoutPriority(1)
                Spacer()
                Toggle("", isOn: $isOn)
                    .padding(.leading, 0)
                    .animation(.easeIn)
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .padding(.bottom, 21)
        }
        .background(Color(UIColor.secondarySystemGroupedBackground))
    }
}

// MARK: - ToggleFieldView_Previews

struct ToggleFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleFieldView(label: "Godkänn", isOn: Binding<Bool>.constant(true))
    }
}
