//
//  TextFieldComponent.swift
//  Marginalen
//
//  Created by michaelst on 2021-04-12.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI
import Combine

struct TextFieldComponent: UIViewRepresentable {
    var placeholder: String = ""
    @Binding var text: String
    @Binding var isResponder: Bool?
    var font: UIFont = UIFont.systemFont(ofSize: Font.fontRatio * 18.0)
    var keyboardType: UIKeyboardType = .default
    var maxLimit: Int?
    var isFirstResponder: Bool = false
    var alignment: NSTextAlignment
    var didBeginEditing: (() -> Void)?
    var didEndEditing: (() -> Void)?

    typealias UIViewType = UITextFieldWithKeyboardObserver

    init(_ placeholder: String,
         text: Binding<String>,
         isResponder: Binding<Bool?>,
         keyboardType: UIKeyboardType,
         maxLimit: Int? = nil,
         isFirstResponder: Bool = false,
         font: Font.Marginalen = .body,
         alignment: NSTextAlignment = .left,
         didBeginEditing: (() -> Void)? = nil,
         didEndEditing: (() -> Void)? = nil) {
        self._text = text
        self._isResponder = isResponder
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.maxLimit = maxLimit
        self.isFirstResponder = isFirstResponder
        self.font = font.font
        self.alignment = alignment
        self.didBeginEditing = didBeginEditing
        self.didEndEditing = didEndEditing
    }

    func makeUIView(context: Context) -> UITextFieldWithKeyboardObserver {
        let view = UITextFieldWithKeyboardObserver()
        view.delegate = context.coordinator
        view.text = text
        view.placeholder = placeholder
        view.font = font
        view.textColor = UIColor.label
        view.keyboardType = keyboardType
        view.autocorrectionType = .no
        view.textAlignment = alignment
        view.addDoneButtonOnKeyboard()
        view.setupKeyboardObserver()
        return view
    }

    func updateUIView(_ uiView: UITextFieldWithKeyboardObserver, context: Context) {
        uiView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        if uiView.text != text {
            uiView.text = text
        }
        if let responder = isResponder {
            uiView.setFirstResponder(responder)
        }
        if isFirstResponder && !context.coordinator.didBecomeFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didBecomeFirstResponder = true
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self, isResponder: $isResponder)
    }
}

extension TextFieldComponent {
    final class Coordinator: NSObject, UITextFieldDelegate {

        var parent: TextFieldComponent
        var didBecomeFirstResponder = false
        @Binding var isResponder: Bool?

        init(_ uiTextView: TextFieldComponent, isResponder: Binding<Bool?>) {
            self.parent = uiTextView
            self._isResponder = isResponder
        }

        private func setResponder(_ isResponder: Bool) {
            DispatchQueue.main.async { self.isResponder = isResponder }
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            setResponder(true)
            parent.didBeginEditing?()
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            parent.didEndEditing?()
            setResponder(false)
            if let parentScrollView = textField.superview(of: UIScrollView.self) {
                if !(parentScrollView.currentFirstResponder() is UITextFieldWithKeyboardObserver) {
                    parentScrollView.contentInset = .zero
                }
            }
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.endEditing(true)
            return true
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let limit = parent.maxLimit {
                guard let textFieldText = textField.text,
                      let rangeOfTextToReplace = Range(range, in: textFieldText)
                else {
                    return true
                }
                let substringToReplace = textFieldText[rangeOfTextToReplace]
                let count = textFieldText.count - substringToReplace.count + string.count
                return count <= limit
            }
            return true
        }
    }
}

extension UITextField {

    func addDoneButtonOnKeyboard() {
        UIBarButtonItem.appearance().tintColor = currentTheme.primaryColor
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("done", comment: "Done button"), style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}

class UITextFieldWithKeyboardObserver: UITextField {

    private var keyboardPublisher: AnyCancellable?

    func setupKeyboardObserver() {
        keyboardPublisher = KeybordManager.shared.$keyboardFrame
            .receive(on: DispatchQueue.main)
            .sink { [weak self] keyboardFrame in
                if let strongSelf = self, let keyboardFrame = keyboardFrame {
                    strongSelf.update(with: keyboardFrame)
                }
        }
    }

    private func update(with keyboardFrame: CGRect) {
        if let parentScrollView = superview(of: UIScrollView.self), isFirstResponder {

            let keyboardFrameInScrollView = parentScrollView.convert(keyboardFrame, from: UIScreen.main.coordinateSpace)

            let scrollViewIntersection = parentScrollView.bounds.intersection(keyboardFrameInScrollView).height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: scrollViewIntersection, right: 0.0)

            parentScrollView.contentInset = contentInsets
            parentScrollView.scrollIndicatorInsets = contentInsets
            parentScrollView.scrollRectToVisible(frame, animated: true)
        }
    }
}

extension UIView {

    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: type)
    }

    func currentFirstResponder() -> UIResponder? {
        if self.isFirstResponder {
            return self
        }

        for view in self.subviews {
            if let responder = view.currentFirstResponder() {
                return responder
            }
        }

        return nil
     }
}
