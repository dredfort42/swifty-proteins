//
//  LigandView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 28.11.2022.
//

import SwiftUI

struct LigandView: View {
	@StateObject private var ligandData: LigandLoader

	init(protein: Protein) {
		_ligandData = StateObject(wrappedValue: LigandLoader(protein: protein))
	}

	var body: some View {
		content
			.onAppear(perform: ligandData.load)
	}

	private var content: some View {
		Group {
			if ligandData.ligandData != nil {
				NavigationView {
					Text(ligandData.ligandData!)
				}
				.navigationTitle(ligandData.proteinFormula!)
			} else {
				Image(systemName: "hourglass")
					.font(.system(size: 42, weight: .thin))
					.foregroundColor(Color(white: 0.50))
					.background(
						SpinningWheelView(wheelSize: 120.0, wheelAnimation: true)
					)
			}
		}
	}
}

struct LigandView_Previews: PreviewProvider {
	static var previews: some View {
		LigandView(protein: ProteinsList().proteins[0])
	}
}

