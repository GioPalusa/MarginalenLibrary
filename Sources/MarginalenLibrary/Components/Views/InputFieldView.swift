//
//  InputFieldView.swift
//  Marginalen
//
//  Created by michaelst on 2021-06-02.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

// MARK: - InputFieldView

struct InputFieldView: View {
    var label: String
    var placeholder: String
    @Binding var text: String
    @Binding var isFocused: Bool?
    var isEditable: Bool
    var keyboardType: UIKeyboardType

    init(label: String,
         placeholder: String = "",
         text: Binding<String>,
         isFocused: Binding<Bool?>? = nil,
         isEditable: Bool = false,
         keyboardType: UIKeyboardType = .default) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self._isFocused = isFocused ?? .constant(nil)
        self.isEditable = isEditable
        self.keyboardType = keyboardType
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text(label)
                        .lineLimit(2)
                        .font(font: .title)
                        .foregroundColor(Color(UIColor.MarginalenColors.bluishGrey.color))
                    Spacer()
                }
                TextFieldView(placeholder: placeholder,
                              text: $text,
                              isFocused: $isFocused,
                              keyboardType: keyboardType,
                              isEditing: isEditable)
                    .disabled(!isEditable)
                    .padding(.top, 4)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 28)
            Divider()
                .frame(height: 1)
        }
        .setFocus(focus: $isFocused)
    }
}

struct SecondaryInputTextField: View {
    let title: String
    let textFieldValue: Binding<String>
    var onEditingChanged: (Bool) -> Void = { _ in }
    var onCommit: () -> Void = { }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                HStack {
                    Text(title)
                        .font(font: .title)
                        .foregroundColor(.marginalen(color: .bluishGrey))
                        .frame(height: 20)
                    Spacer()
                }
                .padding(.top, isSmallDevice ? 16 : 20)

                HStack {
                    TextField("",
                              text: textFieldValue,
                              onEditingChanged: onEditingChanged,
                              onCommit: onCommit)
                    .font(.system(size: 18, weight: .regular, design: .default))
                    Spacer()
                }
                .padding(.top, 4)
                .padding(.bottom, isSmallDevice ? 24 : 28)
            }
            .padding(.horizontal, 16)
            Divider().frame(height: 1)
        }
        .background(Color.secondarySystemGroupedBackground)
    }
}

// MARK: - InputFieldView_Previews

struct InputFieldView_Previews: PreviewProvider {
    static var previews: some View {
        let view = VStack {
            InputFieldView(label: "Label",
                           text: Binding<String>.constant("Text"),
                           isEditable: true)
            InputFieldView(label: "Label",
                           text: Binding<String>.constant("Text"))
            SecondaryInputTextField(title: "Secondary input field", textFieldValue: .constant("Something"))
            Spacer()
        }
        GroupedPreview(view: view)
    }
}
