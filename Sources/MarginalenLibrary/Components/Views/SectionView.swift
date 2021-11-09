//
//  SectionView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-16.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct SectionRow: View {
    var sectionTitle: String
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(sectionTitle)
                    .font(font: .regularTitle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.horizontal, 16)
            .listRowBackground(Color(UIColor.MarginalenColors.veryLightPink.color))
        }.marginalenShadow()
    }
}

struct SectionView<Content: View>: View {
    let cellViews: Content
    @Binding var dataSource: SectionInfo

    init(dataSource: Binding<SectionInfo>, @ViewBuilder cellViews: @escaping () -> Content) {
        self._dataSource = dataSource
        self.cellViews = cellViews()
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text(dataSource.title)
                    .font(font: .regularTitle)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(.horizontal, 16)
            .listRowBackground(Color(UIColor.MarginalenColors.veryLightPink.color))
            VStack(spacing: 0) {
                cellViews
            }
        }.marginalenShadow()
    }
}
