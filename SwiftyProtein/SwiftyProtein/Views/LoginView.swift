//
//  LoginView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 15.11.2022.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {

	@State private var successAuth = false
	@State private var buttonTapped = false

	var body: some View {
		if successAuth {
			ProteinListView()
		} else {
			AuthenticationButton()
				.scaleEffect(buttonTapped ? 0.95 : 1)
				.onTapGesture() {
					buttonTapped.toggle()
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						buttonTapped = false
					}
					authentication()
				}
				.background(
					Image("Background")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.edgesIgnoringSafeArea(.all)
						.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
				)
		}
	}

	func authentication() {

		let context = LAContext()
		var error: NSError?

		// check whether biometric authentication is possible
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			// it's possible, so go ahead and use it
			let reason = "We need to unlock your data."

			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
				// authentication has now completed
				if success {
					// authenticated successfully
					print("SUCCESS")
					successAuth.toggle()
				} else {
					// there was a problem
					print("FAULSE")
				}
			}
		} else {
			// no biometrics
			print("NO BIOMETRICS")
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}

//MARK: - Button view

struct AuthenticationButton: View {

	@State private var buttonRotating = 0.0

	var body: some View {
		ZStack {
			Image(systemName: "faceid")
				.font(.system(size: 64, weight: .thin))
				.foregroundColor(Color(white: 0.2))
		}
		.frame(width: 100, height: 100)
		.background(
			ZStack {
				Circle()
					.fill(Color(white: 0.95))
					.frame(width: 120, height: 120)
					.shadow(color: .cyan.opacity(0.1), radius: 1, x: 0, y: -10)
					.shadow(color: .yellow.opacity(0.1), radius: 1, x: 0, y: 10)
					.shadow(color: .purple.opacity(0.1), radius: 1, x: 10, y: 0)
					.shadow(color: .green.opacity(0.1), radius: 1, x: -10, y: 0)
					.rotationEffect(.degrees(buttonRotating))
					.onAppear {
						withAnimation(.linear(duration: 1)
							.speed(0.1).repeatForever(autoreverses: false)) {
								buttonRotating = 360.0
							}
					}
				Circle()
					.fill(.white)
					.frame(width: 118, height: 118)
			}
		)
	}
}
