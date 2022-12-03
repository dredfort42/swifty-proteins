//
//  LoginView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 15.11.2022.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
	let context = LAContext()
	
	@State private var successAuth = false
	@State private var buttonTapped = false
	
	var body: some View {
		if !checkAuthWithBiometrics() || successAuth {
			ProteinsListView()
		} else {
			Image(systemName: "faceid")
				.font(.system(size: 50, weight: .thin))
				.foregroundColor(Color(white: 0.25))
				.background(
					SpinningWheelView(wheelSize: 120.0, wheelAnimation: true)
				)
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
	
	func checkAuthWithBiometrics() -> Bool {
		var error: NSError?
		
		if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
			return true
		}
		print("NO BIOMETRICS")
		return false
	}
	
	func authentication() {
		let reason = "We need to unlock your data."
		
		context.evaluatePolicy(
			.deviceOwnerAuthenticationWithBiometrics,
			localizedReason: reason
		) { success, authenticationError in
			if success {
				print("BIOMETRICS SUCCESS")
				successAuth.toggle()
			} else {
				print("BIOMETRICS FAULSE")
			}
		}
	}
}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
