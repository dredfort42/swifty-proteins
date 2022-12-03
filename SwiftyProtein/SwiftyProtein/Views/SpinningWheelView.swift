//
//  SpinningWheelView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 01.12.2022.
//

import SwiftUI

struct SpinningWheelView: View {
	var wheelSize: CGFloat = 100.0
	var wheelStartPosition: Double = 0.0
	var wheelAnimation: Bool = false

	@State private var wheelRotating: Double = 0.0

	var body: some View {
		let shadowShift: CGFloat = wheelSize / 10
		let shadowRadius: CGFloat = shadowShift / 10

		Circle()
			.fill(Color(white: 1.0))
			.frame(width: wheelSize, height: wheelSize)
			.shadow(color: .cyan.opacity(0.1), radius: shadowRadius, x: 0, y: -shadowShift)
			.shadow(color: .yellow.opacity(0.1), radius: shadowRadius, x: 0, y: shadowShift)
			.shadow(color: .purple.opacity(0.1), radius: shadowRadius, x: shadowShift, y: 0)
			.shadow(color: .green.opacity(0.1), radius: shadowRadius, x: -shadowShift, y: 0)
			.rotationEffect(.degrees(wheelAnimation ? wheelRotating : wheelStartPosition))
			.padding(10)
			.onAppear {
				if wheelAnimation {
					withAnimation(.linear(duration: 1)
						.speed(0.1).repeatForever(autoreverses: false)) {
							wheelRotating = 360.0
						}
				}
			}
	}
}

struct SpinningWheelView_Previews: PreviewProvider {
	static var previews: some View {
		SpinningWheelView()
	}
}
