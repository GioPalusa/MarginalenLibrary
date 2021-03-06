//
//  SwiftUIView.swift
//
//
//  Created by Giovanni Palusa on 2021-11-18.
//

import SwiftUI

// MARK: - ShortcutButton

public struct ShortcutButton: View {
	public var text: String
	public var image: Image
	public var action: () -> Void
	@Binding public var isSelected: Bool
	public var isLoading: Binding<Bool>? = nil

	public init(text: String, image: Image,
				isSelected: Binding<Bool> = Binding.constant(false),
				isLoading: Binding<Bool>? = nil, action: @escaping () -> Void) {
		self.text = text
		self.image = image
		self._isSelected = isSelected
		self.isLoading = isLoading
		self.action = action
	}

	public var body: some View {
		Button(action: {
			action()
		}, label: {
			VStack {
				Spacer()
				if isLoading != nil {
					LottieAnimation(isAnimating: isLoading)
				} else {
					image
						.font(.system(size: 50))
				}
				Spacer()
				HStack {
					Text(text)
						.foregroundColor(Color(UIColor.label))
						.padding(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
						.font(.system(size: 13))
				}
			}
		})
			.frame(width: 93, height: 100, alignment: .center)
			.marginalenPopOutLook()
			.padding()
	}
}

// MARK: - ShortcutButton_Previews

struct ShortcutButton_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			ShortcutButton(text: "Lägg till", image: Image(systemName: "plus"), isSelected: Binding.constant(false), isLoading: nil, action: {})
				.preferredColorScheme(.dark)
		}
	}
}
