//
//  ProteinCardView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 01.12.2022.
//

import SwiftUI

struct ProteinCardView: View {

	var protein: Protein
	
	var body: some View {
		NavigationLink {
			LegandView(protein: protein)
		} label: {
			ZStack {
				Circle()
					.fill(.white)
					.frame(width: 50, height: 50)
					.padding(5)
					.shadow(color: .cyan.opacity(0.1), radius: 1, x: 0, y: -6)
					.shadow(color: .yellow.opacity(0.1), radius: 1, x: 0, y: 6)
					.shadow(color: .purple.opacity(0.1), radius: 1, x: 6, y: 0)
					.shadow(color: .green.opacity(0.1), radius: 1, x: -6, y: 0)
					.rotationEffect(.degrees(Double(protein.id % 10 * 72)))
				Text(protein.name)
					.font(.system(size: 16, weight: .light))
					.foregroundColor(Color(white: 0.2))
			}
		}
	}
}

struct ProteinCardView_Previews: PreviewProvider {
	static var previews: some View {
		ProteinCardView(protein: proteins[0])
	}
}
