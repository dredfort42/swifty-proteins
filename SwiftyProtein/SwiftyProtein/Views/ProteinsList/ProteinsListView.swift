//
//  ProteinsListView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 25.11.2022.
//

import SwiftUI

struct ProteinsListView: View {
	@State private var searchText: String = ""
	@State private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 100))]
	
	private let proteins = ProteinsList().proteins
	
	var body: some View {
		NavigationStack {
			ScrollView(.horizontal){
				LazyHGrid(rows: gridLayout, alignment: .center, spacing: 10) {
					ForEach(filteredProteins, id: \.id) { protein in
						NavigationLink {
							LigandView(protein: protein)
						} label: {
							ZStack {
								SpinningWheelView(wheelSize: 75, wheelStartPosition: Double(arc4random_uniform(360)))
								Text(protein.name)
									.font(.system(size: 16, weight: .light))
									.foregroundColor(Color(white: 0.2))
							}
						}
					}
				}
				.padding(21)
			}
			.background(
				Image("Background")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.edgesIgnoringSafeArea(.all)
					.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
			)
			.navigationTitle("Proteins")
			.searchable(text: $searchText, prompt: "Search for a protein")
		}
		.accentColor(.black)
	}
	
	var filteredProteins: [Protein] {
		if searchText.isEmpty {
			return proteins
		} else {
			return proteins.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
		}
	}
}

struct ProteinListView_Previews: PreviewProvider {
	static var previews: some View {
		ProteinsListView()
	}
}
