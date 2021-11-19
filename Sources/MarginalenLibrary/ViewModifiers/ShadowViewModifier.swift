//
//  ShadowViewModifier.swift
//  Created by Giovanni Palusa on 2021-11-18.
//

import SwiftUI

public struct MarginalenLook: ViewModifier {
	public func body(content: Content) -> some View {
		content
			.background(Color.elevatedBackground)
			.cornerRadius(10)
			.shadow(color: .black.opacity(0.15), radius: 4, x: 0, y: 4)

	}
}

public enum PopOutLookStyle {
	case standard
}

extension View {
	public func marginalenPopOutLook(style: PopOutLookStyle = .standard) -> some View {
		modifier(MarginalenLook())
	}
}
