//
//  RefreshableScrollView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-10-21.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct RefreshableScrollView<Content: View>: View {
    @Binding var isRefreshing: Bool

    private var content: () -> Content
    private var refreshAction: () -> Void
    private let threshold: CGFloat = 50.0

    init(isRefreshing: Binding<Bool>,
         action: @escaping () -> Void,
         @ViewBuilder content: @escaping () -> Content) {
        self._isRefreshing = .init(projectedValue: isRefreshing)
        self.content = content
        self.refreshAction = action
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                if isRefreshing {
                    ProgressView().padding(.top, 8)
                }
                content()
                    .anchorPreference(key: OffsetPreferenceKey.self, value: .top) {
                        geometry[$0].y
                    }
            }
            .onPreferenceChange(OffsetPreferenceKey.self) { offset in
                if offset > threshold {
                    guard !isRefreshing else { return }
                    isRefreshing = true
                    refreshAction()
                }
            }
        }
    }
}

private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
