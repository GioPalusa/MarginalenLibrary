//
//  PDFViewRepresentable.swift
//  Marginalen
//
//  Created by michaelst on 2021-05-05.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import PDFKit

struct PDFViewRepresentable: UIViewRepresentable {
    let urlString: String?

    func makeUIView(context: UIViewRepresentableContext<PDFViewRepresentable>) -> PDFViewRepresentable.UIViewType {
        let pdfView = PDFView()
        pdfView.displayMode = .singlePageContinuous
        pdfView.autoScales = true
        if let urlString = urlString, let url = URL(string: urlString) {
            pdfView.document = PDFDocument(url: url)
        }
        return pdfView
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PDFViewRepresentable>) {
    }
}
