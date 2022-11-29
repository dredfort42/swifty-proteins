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
