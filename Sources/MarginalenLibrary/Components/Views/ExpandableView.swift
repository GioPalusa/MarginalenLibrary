//
//  ExpandableView.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-16.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct FAQExpandableView: View {
    var cellInfo: CellInfo
    var onTap: (() -> Void)

    @State private var height: CGFloat = .zero

    init(cellInfo: CellInfo,
         onTap: @escaping (() -> Void)) {
        self.cellInfo = cellInfo
        self.onTap = onTap
    }

    var infoView: some View {
        HStack {
            HTMLText(text: cellInfo.body ?? "", fontSize: 14, dynamicHeight: $height)
                .frame(minHeight: height)
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 26)
    }

    var body: some View {
        ExpandableView(title: cellInfo.title, content: {
            infoView
        }, onTap: onTap)
    }
}

struct ExpandableView<Content: View>: View {
    var icon: Icon?
    var title: String
    var subtitle: String?
    var content: () -> Content
    var onTap: (() -> Void)

    var body: some View {
        Expandable(icon: icon, title: title, subtitle: subtitle, content: content)
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        onTap()
                    }
            )
    }
}

// MARK: - ExpandableView

private struct Expandable<Content: View>: View {
    var icon: Icon?
    var title: String
    var subtitle: String?
    var content: () -> Content

    @State private var height: CGFloat = .zero
    @State var isExpanded = false

    var titleView: some View {
        HStack {
            if let icon = icon {
                icon
            }
            VStack(spacing: 8) {
                Text(title)
                    .leadingAlignment()
                    .font(font: .title)
                    .fixedSize(horizontal: false, vertical: true)

                if let subtitle = subtitle {
                    Text(subtitle)
                        .leadingAlignment()
                        .font(font: .smallText)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer()
            Icon(.plus)
                .colorMultiply(Color(UIColor.MarginalenColors.primaryRed.color))
                .rotationEffect(isExpanded ? .degrees(45) : .zero)
        }
        .padding(.vertical, 20)
    }

    var body: some View {
        VStack {
            titleView
                .padding(.horizontal, 16)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            if isExpanded {
                VStack {
                    content()
                        .padding(.bottom, 26)
                }
            }
        }
        .background(Color(UIColor.secondarySystemGroupedBackground))
    }
}

// MARK: - ExpandableView_Previews

struct ExpandableView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 0) {
                FAQExpandableView(cellInfo: FAQQuestion(title: "Title", body: "Body"), onTap: {})
                Divider()

                FAQExpandableView(cellInfo: FAQQuestion(title: "Title", body: "Body"), onTap: {})
                Divider()

                FAQExpandableView(cellInfo: FAQQuestion(title: "Title", body: "Body"), onTap: {})
                Divider()

                ExpandableView(title: "Title", content: {
                    ZStack {
                        Rectangle().frame(width: 200, height: 50)
                        Text("Custom object").foregroundColor(.white)
                    }
                }, onTap: {})
                Divider()

                ExpandableView(title: "Title", subtitle: "Subtitle") {
                    ZStack {
                        Rectangle().frame(width: 200, height: 50)
                        Text("Custom object").foregroundColor(.white)
                    }
                } onTap: { }
                Divider()
            }
        }.background(Color(UIColor.MarginalenColors.veryLightPink.color))
    }
}
