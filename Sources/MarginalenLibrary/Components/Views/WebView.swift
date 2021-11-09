//
//  WebView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-27.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - WebViewStateModel

class WebViewStateModel: ObservableObject {
    @Published var pageTitle: String = "Web View"
    @Published var loading: Bool = false
    @Published var canGoBack: Bool = false
    @Published var goBack: Bool = false
}

// MARK: - WebView

struct WebView: View {
    // MARK: Lifecycle

    init(urlRequest: URLRequest?, webViewStateModel: WebViewStateModel = WebViewStateModel()) {
        self.urlRequest = urlRequest
        self.webViewStateModel = webViewStateModel
    }

    init(url: URL?, webViewStateModel: WebViewStateModel = WebViewStateModel()) {
        self.webViewStateModel = webViewStateModel
        guard let url = url else { generateReturnError(message: "Couldn't create URL")
            self.urlRequest = nil
            return
        }
        self.urlRequest = URLRequest(url: url)
    }

    init(urlString: String?, webViewStateModel: WebViewStateModel = WebViewStateModel()) {
        self.webViewStateModel = webViewStateModel
        guard let url = URL(string: urlString ?? "") else { generateReturnError(message: "Couldn't create URL")
            self.urlRequest = nil
            return
        }
        self.urlRequest = URLRequest(url: url)
    }

    @ObservedObject var webViewStateModel: WebViewStateModel

    let urlRequest: URLRequest?

    var body: some View {
        if let request = urlRequest {
            WebViewWrapper(webViewStateModel: webViewStateModel,
                           request: request)
        } else {
            EmptyView()
        }
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(urlRequest: URLRequest(url: URL(string: "https://www.google.com")!), webViewStateModel: WebViewStateModel())
    }
}
