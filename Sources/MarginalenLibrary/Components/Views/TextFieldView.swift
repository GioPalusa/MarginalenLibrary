//
//  TextFieldView.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-08.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//
import SwiftUI

struct TextFieldView: View {
    var placeholder: String
    @Binding var text: String
    @Binding var isFocused: Bool?
    var keyboardType: UIKeyboardType
    var maxLimit: Int?
    @State var isEditing: Bool
    var font: Font.Marginalen = .body
    var alignment: NSTextAlignment = .left
    var didBeginEditing: (() -> Void)?
    var didEndEditing: (() -> Void)?

    init(placeholder: String = "",
         text: Binding<String>,
         isFocused: Binding<Bool?>? = nil,
         keyboardType: UIKeyboardType = .default,
         maxLimit: Int? = nil,
         isEditing: Bool = false,
         font: Font.Marginalen = .body,
         alignment: NSTextAlignment = .left,
         didBeginEditing: (() -> Void)? = nil,
         didEndEditing: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self._isFocused = isFocused ?? .constant(nil)
        self.keyboardType = keyboardType
        self.maxLimit = maxLimit
        self._isEditing = State(wrappedValue: isEditing)
        self.font = font
        self.alignment = alignment
        self.didBeginEditing = didBeginEditing
        self.didEndEditing = didEndEditing
    }

    var body: some View {
        TextFieldComponent(placeholder,
                           text: $text,
                           isResponder: $isFocused,
                           keyboardType: keyboardType,
                           maxLimit: maxLimit,
                           isFirstResponder: isEditing,
                           font: font,
                           alignment: alignment,
                           didBeginEditing: didBeginEditing,
                           didEndEditing: didEndEditing)
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(placeholder: "Placeholder", text: Binding<String>.constant("Text"))
    }
}
