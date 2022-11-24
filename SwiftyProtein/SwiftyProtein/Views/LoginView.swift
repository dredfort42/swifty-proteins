//
//  LoginView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 15.11.2022.
//

import SwiftUI

struct LoginView: View {
	var body: some View {
		VStack {
			AuthenticationButton()
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

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}

//MARK: - Button view

struct AuthenticationButton: View {
	@State var buttonTapped = false
	@State var buttonPressed = false

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
					.shadow(color: Color(.sRGBLinear, red: 1.0, green: 0.0, blue: 0.0, opacity: 0.2), radius: 2, x: -2, y: 3)
					.shadow(color: Color(.sRGBLinear, red: 0.0, green: 1.0, blue: 0.0, opacity: 0.2), radius: 2, x: -2, y: -3)
					.shadow(color: Color(.sRGBLinear, red: 0.0, green: 0.0, blue: 1.0, opacity: 0.2), radius: 2, x: 2, y: 3)
				Circle()
					.fill(.white)
					.frame(width: 118, height: 118)
			}
		)
		.scaleEffect(buttonTapped ? 0.95 : 1)
		.onTapGesture() {
			authentication()
			buttonTapped.toggle()
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				buttonTapped = false
			}
		}
	}

	func authentication() {
		print("Button")
	}
}
