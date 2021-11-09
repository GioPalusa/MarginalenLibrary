//
//  GroupedPreview.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-25.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct GroupedPreview<PreviewView: View>: View {
    let view: PreviewView
    var useNavigationView: Bool = false

    var iPhone11ProView: some View {
        view
            .previewDevice("iPhone 11 Pro")
            .previewDisplayName("iPhone 11 Pro")
    }

    var iPhone11ProDarkModeView: some View {
        view
            .previewDevice("iPhone 11 Pro")
            .previewDisplayName("iPhone 11 Pro")
            .environment(\.colorScheme, .dark)
    }

    var iPhone11SEView: some View {
        view
            .previewDevice(.init(rawValue: "iPhone SE (1st generation)"))
            .previewDisplayName("iPhone SE")
    }

    var views: some View {
        Group {
            iPhone11ProView
            iPhone11ProDarkModeView
            iPhone11SEView
        }
    }

    var navigationViews: some View {
        Group {
            NavigationView {
                iPhone11ProView
            }
            NavigationView {
                iPhone11ProDarkModeView
            }
            NavigationView {
                iPhone11SEView
            }
            // This is also needed for navigaion preview of SE. Don't know why...
            .previewDevice("iPhone SE (1st generation)")
            .previewDisplayName("iPhone SE")
        }
    }

    var body: some View {
        if useNavigationView {
            navigationViews
        } else {
            views
        }
    }
}
