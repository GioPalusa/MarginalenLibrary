//
//  SimpleCellView.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-08.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct SimpleCellView: View {
    var placeholder: String
    var label: String
    @Binding var text: String
    var isEditable: Bool = false
    var keyboardType: UIKeyboardType = .default
    var maxLimit: Int?
    var isDividerHidden: Bool = false
    @State var showTextField: Bool = false
    var onTap: (() -> Void) = {}

    init(placeholder: String = "",
         label: String,
         text: Binding<String>,
         isEditable: Bool = false,
         keyboardType: UIKeyboardType = .default,
         maxLimit: Int? = nil,
         isDividerHidden: Bool = false,
         onTap: @escaping (() -> Void) = {}) {
        self.placeholder = placeholder
        self.label = label
        self._text = text
        self.isEditable = isEditable
        self.keyboardType = keyboardType
        self.maxLimit = maxLimit
        self.isDividerHidden = isDividerHidden
        self.onTap = onTap
    }

    var labelView: some View {
        HStack {
            Text(label)
                .lineLimit(2)
                .font(font: .title)
                .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
            Spacer()
        }
    }

    var textView: some View {
        HStack {
            Text(text)
                .lineLimit(nil)
                .font(font: .largeText)
            Spacer()
        }
    }

    var textFieldView: some View {
        HStack {
            TextFieldView(placeholder: placeholder,
                          text: $text,
                          keyboardType: keyboardType,
                          maxLimit: maxLimit,
                          isEditing: true,
                          font: .largeText)
                .frame(height: 20)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(spacing: 0) {
                    labelView
                        .padding(.bottom, 4)
                    if showTextField {
                        textFieldView
                    } else {
                        textView
                    }
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 28)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded { _ in
                    if isEditable {
                        showTextField.toggle()
                        onTap()
                    }
                }
            )
            Divider()
                .frame(height: 1)
                .hidden(isDividerHidden)
        }
    }
}

struct SimpleCellView_Previews: PreviewProvider {
    static var previews: some View {
        let view = VStack(spacing: 0) {
            SimpleCellView(label: "Label", text: Binding<String>.constant("Text"), isEditable: true)
            SimpleCellView(label: "Label", text: Binding<String>.constant("Text"))
            Spacer()
        }
        GroupedPreview(view: view)
    }
}
