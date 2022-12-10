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
	@State private var backgroundColor: UIColor = ([.red, .orange, .yellow, .green, .blue, .purple, .magenta, .white, .black].randomElement() ?? .white)

	var body: some View {
		let shadowShift: CGFloat = wheelSize / 10
		let shadowRadius: CGFloat = shadowShift / 10
		ZStack {
			Circle()
				.fill(.white)
				.shadow(color: .cyan.opacity(0.15), radius: shadowRadius, x: 0, y: -shadowShift)
				.shadow(color: .yellow.opacity(0.15), radius: shadowRadius, x: 0, y: shadowShift)
				.shadow(color: .purple.opacity(0.15), radius: shadowRadius, x: shadowShift, y: 0)
				.shadow(color: .green.opacity(0.15), radius: shadowRadius, x: -shadowShift, y: 0)
				.rotationEffect(.degrees(wheelAnimation ? wheelRotating : wheelStartPosition))
			Circle()
				.fill(Color(backgroundColor.withAlphaComponent(0.05)))
		}
		.frame(width: wheelSize, height: wheelSize)
		.padding(10)
		.onAppear {
			if wheelAnimation {
				withAnimation(
					.linear(duration: 1)
					.speed(0.1)
					.repeatForever(autoreverses: false)
				) {
					wheelRotating = 360.0
				}
				withAnimation(
					.easeInOut(duration: 1)
					.speed(0.25)
					.repeatForever(autoreverses: true)
				) {
					backgroundColor = ([.red, .orange, .yellow, .green, .blue, .purple, .magenta, .white, .black].randomElement() ?? .white)
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
