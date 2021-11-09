//
//  SearchBar.swift
//  Marginalen
//
//  Created by Jacob Ahlberg on 2021-05-24.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - SearchBar

struct SearchBar: View {
    @Binding var text: String

    @State private var isEditing = false

    private let placeholder: String
    private let deviceRatio: CGFloat = UIDevice.current.isSmall ? 0.7 : 1

    init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }

    var body: some View {
        HStack {
            HStack(spacing: 13) {
                Image("search")
                    .resizable()
                    .frame(width: 24 * deviceRatio, height: 24 * deviceRatio)
                    .padding(.leading, 12)
                TextField(placeholder, text: $text)
                    .font(font: .body)
                    .padding(.vertical, 14 * deviceRatio)
                    .onTapGesture {
                        self.isEditing = true
                    }
            }

            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""

                }) {
                    Text("Cancel")
                        .font(font: .body)
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
        .background(Color.marginalen(color: .veryLightPink))
        .cornerRadius(8)
    }
}

// MARK: - SearchBar_Previews

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), placeholder: "Ange företagets namn")
    }
}
