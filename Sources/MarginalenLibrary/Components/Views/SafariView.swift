//
//  SafariView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-06-08.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import SafariServices
#if !os(macOS)
import UIKit
#endif

@available(iOS 13.0, *)
struct SafariViewWrapper: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewWrapper>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewWrapper>) {

    }
}

@available(iOS 13.0, *)
struct SafariView: View {
    let url: URL

    init(url: URL) {
        self.url = url
    }

    init(urlString: String) {
        self.url = URL(string: urlString)!
    }

    var body: some View {
        SafariViewWrapper(url: url)
    }
}
