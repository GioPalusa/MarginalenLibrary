//
//  WebInvoiceView.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-31.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct WebInvoiceView: View {
    @ObservedObject var viewModel: InvoiceVM

    var body: some View {
        VStack(spacing: 0) {
            WebView(urlRequest: viewModel.request, webViewStateModel: WebViewStateModel())
            BottomView()
                .environmentObject(viewModel)
        }
        .navigationBarTitle("Invoice", displayMode: .inline)
    }
}

struct WebInvoiceView_Previews: PreviewProvider {

    static var previews: some View {
        WebInvoiceView(viewModel: InvoiceVMFactory.webInvoiceViewingMock())
    }
}
