//
//  SwiftUIView.swift
//
//
//  Created by Giovanni Palusa on 2021-11-18.
//

import SwiftUI

// MARK: - DotSpinner

struct DotSpinner: View {
	// MARK: Internal

	var isLoading: Binding<Bool>?
	var width: CGFloat = 25
	var height: CGFloat = 25

	var body: some View {
		Image("dot")
			.resizable()
			.scaledToFit()
			.rotationEffect(Angle(degrees: isLoading?.wrappedValue ?? false ? 360 : 0))
			.animation(isLoading?.wrappedValue ?? false ?
				Animation.easeInOut(duration: 0.9).repeatForever(autoreverses: false) :
				Animation.default, value: isLoading?.wrappedValue)
			.frame(width: animationWidth,
			       height: animationHeight,
			       alignment: .center)
			.onChange(of: isLoading?.wrappedValue) { newValue in
				self.animationWidth = newValue ?? false ? width : 0
				self.animationHeight = newValue ?? false ? height : 0
			}
	}

	// MARK: Private

	@State private var animationWidth: CGFloat = 0
	@State private var animationHeight: CGFloat = 0
}

// MARK: - SwiftUIView_Previews

struct DotSpinner_Previews: PreviewProvider {
	static var previews: some View {
		DotSpinner()
	}
}
