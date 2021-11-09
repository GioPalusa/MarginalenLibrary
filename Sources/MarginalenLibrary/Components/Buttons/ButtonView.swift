//
//  ButtonView.swift
//  Marginalen
//
//  Created by michaelst on 2021-03-26.
//  Copyright © 2021 Marginalen Bank. All rights reserved.
//

import SwiftUI

struct PrimaryButton: View {
    var text: String
    var action: () -> Void
    var image: Image?
    @Binding var isLoading: Bool
    @Binding var isFinished: Bool
    @State var backgroundColor: Color = Color.marginalen(color: .primaryRed)
    private let height: CGFloat = 50

    @SwiftUI.Environment(\.isEnabled) var isEnabled

    init(text: String, action: @escaping () -> Void, image: Image? = nil, isLoading: Binding<Bool>? = Binding<Bool>.constant(false), isFinished: Binding<Bool>? = Binding<Bool>.constant(false)) {
        self.text = text
        self.action = action
        self.image = image
        self._isLoading = isLoading ?? Binding<Bool>.constant(false)
        self._isFinished = isFinished ?? Binding<Bool>.constant(false)
    }

    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    self.action()
                }
            }) {
                ZStack {
                    if isLoading {
                        ActivityIndicatorComponent(isAnimating: Binding<Bool>.constant(true))
                            .padding()
                    } else if isFinished {
                        CheckmarkComponent(frame: CGRect(x: 0, y: 0, width: height, height: height))
                            .frame(maxWidth: height, maxHeight: height)
                            .onAppear {
                                withAnimation {
                                    backgroundColor = Color.marginalen(color: .greenyBlue)
                                }
                            }
                            .background(backgroundColor)
                    } else {
                        HStack {
                            image?
                                .resizable()
                                .scaledToFit()
                                .frame(width: height, height: height, alignment: .leading)
                            Spacer()
                        }.padding(.leading, 16)
                        Text(text)
                            .font(font: .regularTitle)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .center)
                    }
                }
            }
            .frame(maxWidth: isLoading || isFinished ? height : .infinity, maxHeight: height)
            .background(isEnabled ? isFinished ? Color.clear : Color.marginalen(color: .primaryRed) : Color.marginalen(color: .primaryRed, withAlpha: 0.5))
            .cornerRadius(isLoading || isFinished ? height / 2 : 4)
            .buttonShadow()
        }
        .padding(.horizontal, 32)
    }
}

struct SecondaryButton: View {
    var text: String
    var action: () -> Void
    private let height: CGFloat = 50

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(font: .regularTitle)
                .foregroundColor(Color(UIColor.MarginalenColors.darkIndigo.color))
                .frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .center)
        }
        .background(Color(UIColor.systemBackground))
        .border(Color(UIColor.MarginalenColors.darkIndigo.color), width: 2)
        .cornerRadius(4)
        .padding(.horizontal, 32)
    }
}

struct DiscreteButton: View {
    var text: String
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .font(font: .boldButtonText)
        })
    }
}

struct CellButton: View {
    let title: String
    let text: String?
    let icon: Icon?
    var action: () -> Void
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 8) {
                HStack(spacing: 8) {
                    if let icon = icon {
                        icon
                            .resizable()
                            .frame(width: 32, height: 32)
                    }

                    VStack {
                        Text(title)
                            .leadingAlignment()
                            .font(font: .title)
                            .foregroundColor(.label)
                        Text(text ?? "")
                            .leadingAlignment()
                            .font(font: .smallText)
                            .foregroundColor(.label)
                    }
                }
                .padding(.leading, 16)

                Icon(.rightChevron)
                    .foregroundColor(.marginalen(color: .primaryRed))
                    .padding(.trailing, 8)
            }
            .frame(height: 88)
        })
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrimaryButton(text: "PrimaryButton", action: {}, isLoading: Binding.constant(false), isFinished: Binding.constant(false))
            PrimaryButton(text: "PrimaryButton", action: {}, isLoading: Binding.constant(true), isFinished: Binding.constant(false))
            PrimaryButton(text: "PrimaryButton", action: {}, isLoading: Binding.constant(false), isFinished: Binding.constant(true))
            PrimaryButton(text: "PrimaryButton", action: {}, isLoading: Binding.constant(false), isFinished: Binding.constant(false))
                .environment(\.isEnabled, false)
            SecondaryButton(text: "SecondaryButton", action: {})
            PrimaryButton(text: "PrimaryButton", action: {}, image: Image("BankID-white"))
            CellButton(title: "Title", text: "Text", icon: Icon(.error), action: {})
        }.previewLayout(.sizeThatFits)
    }
}
