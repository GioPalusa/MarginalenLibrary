//
//  SafariViewComponent.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-19.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariViewComponent: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewComponent>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewComponent>) {

    }
}
