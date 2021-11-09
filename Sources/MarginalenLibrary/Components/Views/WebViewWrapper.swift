//
//  WebViewWrapper.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import WebKit

// MARK: - WebViewWrapper

final class WebViewWrapper: UIViewRepresentable {
    // MARK: Lifecycle

    init(webViewStateModel: WebViewStateModel,
         request: URLRequest) {
        self.request = request
        self.webViewStateModel = webViewStateModel
    }

    // MARK: Internal

    final class Coordinator: NSObject {
        // MARK: Lifecycle

        init(webViewStateModel: WebViewStateModel) {
            self.webViewStateModel = webViewStateModel
        }

        // MARK: Internal

        @ObservedObject var webViewStateModel: WebViewStateModel
    }

    @ObservedObject var webViewStateModel: WebViewStateModel

    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(request)
        return view
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if uiView.canGoBack, webViewStateModel.goBack {
            uiView.goBack()
            webViewStateModel.goBack = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(webViewStateModel: webViewStateModel)
    }
}
