//
//  AsyncContentView.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-15.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import Combine

struct AsyncContentView<Source: LoadableObject, LoadingView: View, ErrorView: View, Content: View>: View {
    @ObservedObject var source: Source
    var loadingView: LoadingView
    var errorView: ErrorView
    var content: (Source.Output) -> Content

    init(source: Source, loadingView: LoadingView, errorView: ErrorView, @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.loadingView = loadingView
        self.errorView = errorView
        self.content = content
    }

    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            loadingView
        case .failed:
//            EmptyView()
            errorView
        case .loaded(let output):
            withAnimation {
                content(output)
            }
        }
    }
}

typealias DefaultProgressView = ActivityIndicatorComponent
typealias DefaultErrorView = EmptyView

extension AsyncContentView where ErrorView == DefaultErrorView, LoadingView == DefaultProgressView {
    init(
        source: Source,
        @ViewBuilder content: @escaping (Source.Output) -> Content
    ) {
        self.init(
            source: source,
            loadingView: ActivityIndicatorComponent(isAnimating: Binding<Bool>.constant(true),
                                                    color: UIColor.MarginalenColors.primaryRed.color,
                                                    style: .large),
            errorView: EmptyView(),
            content: content
        )
    }
}
