//
//  SwiftUIView.swift
//  
//
//  Created by Giovanni Palusa on 2021-11-18.
//

import SwiftUI

public struct MainButton: View {
	public var text: String
	public var action: () -> Void
	private let height: CGFloat = 50
	public var isLoading: Binding<Bool>? = nil

	public var body: some View {
		Button(action: action) {
			HStack {
				Spacer()
				if isLoading != nil {
					LottieAnimation(isAnimating: isLoading, width: 75, height: 75, animationName: .ballWithStick)
				}
				Text(text)
					.foregroundColor(Color(UIColor.label))
					.frame(maxWidth: .infinity, minHeight: height, maxHeight: height, alignment: .center)
				Spacer()
			}
		}
		.background(Color(UIColor.systemBackground))
		.padding(.horizontal, 32)
		.marginalenPopOutLook()
	}
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
		MainButton(text: "Button", action: {})
    }
}
