//
//  SwiftUIView.swift
//  
//
//  Created by Giovanni Palusa on 2021-11-18.
//

import SwiftUI

public struct ToggleView: View {
	var label: String
	@Binding var isOn: Bool
	var isLoading: Binding<Bool>? = nil

	public var body: some View {
		VStack(spacing: 0) {
			HStack {
				Text(label)
					.foregroundColor(Color(UIColor.label))
					.frame(height: 20)
					.layoutPriority(1)

				Spacer()
				if isLoading != nil {
					LottieAnimation(isAnimating: isLoading)
				}
				Toggle("", isOn: $isOn)
					.padding(.leading, 0)
					.animation(.easeIn, value: 0)
					.labelsHidden()
			}
			.padding(.horizontal, 16)
			.padding(.top, 20)
			.padding(.bottom, 21)
		}
		.background(Color(UIColor.secondarySystemGroupedBackground))
	}
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ToggleView(label: "Toggle this", isOn: Binding<Bool>.constant(true))
		}
    }
}
