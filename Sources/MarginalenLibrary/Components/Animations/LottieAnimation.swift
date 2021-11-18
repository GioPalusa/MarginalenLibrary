//
//  SwiftUIView.swift
//  
//
//  Created by Giovanni Palusa on 2021-11-18.
//

import SwiftUI

struct LottieAnimation: View {
	var isAnimating: Binding<Bool>?
	var width: CGFloat = 50
	var height: CGFloat = 50
	var animationName: LottieFile = .infinite

	var body: some View {
		LottieView(name: animationName.rawValue,
				   loopMode: (isAnimating?.wrappedValue ?? false) ? .loop : .playOnce)
			.frame(width: height, height: width)
	}
}

struct LottieAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimation()
    }
}
