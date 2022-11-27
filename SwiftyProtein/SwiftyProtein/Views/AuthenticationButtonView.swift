//
//  AuthenticationButtonView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 27.11.2022.
//

import SwiftUI

struct AuthenticationButtonView: View {

	@State private var buttonRotating = 0.0
	@State private var shadowRotating = 0.0

	var body: some View {
		Image(systemName: "faceid")
			.font(.system(size: 60, weight: .thin))
			.foregroundColor(Color(white: 0.2))
			.background(
				ZStack {
					Circle()
						.fill(.white)
						.frame(width: 120, height: 120)
						.shadow(color: .cyan.opacity(0.1), radius: 1, x: 0, y: -12)
						.shadow(color: .yellow.opacity(0.1), radius: 1, x: 0, y: 12)
						.shadow(color: .purple.opacity(0.1), radius: 1, x: 12, y: 0)
						.shadow(color: .green.opacity(0.1), radius: 1, x: -12, y: 0)
						.rotationEffect(.degrees(buttonRotating))
					Circle()
						.fill(.white)
						.frame(width: 118, height: 118)
						.shadow(color: .cyan.opacity(0.2), radius: 0.75, x: 0, y: -3)
						.shadow(color: .yellow.opacity(0.2), radius: 0.75, x: 0, y: 3)
						.shadow(color: .purple.opacity(0.2), radius: 0.75, x: 3, y: 0)
						.shadow(color: .green.opacity(0.2), radius: 0.75, x: -3, y: 0)
						.rotationEffect(.degrees(buttonRotating))
				}
			)
			.onAppear {
				withAnimation(.linear(duration: 1)
					.speed(0.1).repeatForever(autoreverses: false)) {
						buttonRotating = 360.0
					}
			}
	}
}

struct AuthenticationButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationButtonView()
    }
}
