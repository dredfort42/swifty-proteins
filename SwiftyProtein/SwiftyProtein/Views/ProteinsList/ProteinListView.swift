//
//  ProteinListView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 25.11.2022.
//

import SwiftUI

struct ProteinListView: View {

	@State private var showProteinsList: Bool = false
	@State private var searchText: String = ""
	@State private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 75))]

	var body: some View {
		NavigationStack {
			if showProteinsList {
				ScrollView {
					LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
						ForEach(filteredProteins, id: \.id) { protein in
							ProteinCardView(protein: protein)
						}
					}
					.padding(21)
				}
				.navigationTitle("Proteins")
				.searchable(text: $searchText, prompt: "Search for a protein")
			}
		}
		.onAppear {
			withAnimation() {
				showProteinsList.toggle()
			}
		}
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
		ProteinListView()
	}
}
