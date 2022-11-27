//
//  ProteinListView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 25.11.2022.
//

import SwiftUI

struct ProteinListView: View {

	@State private var layerTrancparency = 0.0


	var body: some View {

		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
			.opacity(layerTrancparency)
			.onAppear {
				withAnimation(.easeIn(duration: 1.0)) {
					layerTrancparency = 1.0
				}
			}

	}
	
}

struct ProteinListView_Previews: PreviewProvider {
	static var previews: some View {
		ProteinListView()
	}
}
