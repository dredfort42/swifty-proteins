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
			Spacer()
			Image(systemName: "globe")
				.imageScale(.large)
				.foregroundColor(.black)
			Text("Hello, world!")
				.padding(21)
			ZStack {
				Circle()
					.frame(width: 100, height: 100)
					.foregroundColor(.orange)
				Circle()
					.frame(width: 92, height: 92)
					.foregroundColor(.white)
				Button(
					action: authentication,
					label: {Image(systemName: "faceid")
							.resizable()
							.foregroundColor(.orange)
							.frame(width: 60, height: 60)
					}
				)
			}

			Spacer()
		}
	}

	//MARK: - Functions

	func authentication() {
		print("Button")
	}

}

struct LoginView_Previews: PreviewProvider {
	static var previews: some View {
		LoginView()
	}
}
