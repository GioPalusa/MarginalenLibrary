//
//  LottieViewRepresentable.swift
//  animationTest
//
//  Created by Giovanni Palusa on 2021-11-18.
//

import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
	var name: String
	var loopMode: LottieLoopMode = .playOnce

	var animationView = AnimationView()

	func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
		let view = UIView(frame: .zero)

		animationView.animation = Animation.named(name)
		animationView.contentMode = .scaleAspectFit
		animationView.loopMode = loopMode
		animationView.play()

		animationView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(animationView)

		NSLayoutConstraint.activate([
			animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
			animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
		])

		return view
	}

	func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {}
}
