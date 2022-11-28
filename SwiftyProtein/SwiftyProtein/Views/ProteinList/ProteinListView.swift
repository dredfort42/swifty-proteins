//
//  ProteinListView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 25.11.2022.
//

import SwiftUI

struct ProteinListView: View {

	@State private var buttonRotating = 0.0
	
	@State private var showLegandsList: Bool = false
	@State private var searchText: String = ""

	var body: some View {
		NavigationView {
			if showLegandsList {
				List(filteredLegands, id: \.id) {
					legand in
					NavigationLink {
						LegandView(legand: legand)
					} label: {
						HStack {
							ZStack {
								Circle()
									.fill(.white)
									.frame(width: 36, height: 36)
									.shadow(color: .cyan.opacity(0.1), radius: 1, x: 0, y: -6)
									.shadow(color: .yellow.opacity(0.1), radius: 1, x: 0, y: 6)
									.shadow(color: .purple.opacity(0.1), radius: 1, x: 6, y: 0)
									.shadow(color: .green.opacity(0.1), radius: 1, x: -6, y: 0)
									.rotationEffect(.degrees(buttonRotating - Double(legand.id % 10 * 72)))
									.onAppear {
										withAnimation(.linear(duration: 1)
											.speed(0.1).repeatForever(autoreverses: false)) {
												buttonRotating = 360.0
											}
									}
								Text((legand.id + 1).description)
									.font(.system(size: 12, weight: .regular))
							}
							Text(legand.name)
								.font(.system(size: 24, weight: .light))
								.padding(.leading, 21.0)
								.padding(.top, 6.0)
								.padding(.bottom, 6.0)
						}
					}
				}
				.navigationTitle("Proteins")
				.searchable(text: $searchText, prompt: "Search for a legand")
				.transition(AnyTransition.move(edge: .bottom))
			}
		}
		.onAppear {
			withAnimation() {
				showLegandsList.toggle()
			}
		}
	}

	var filteredLegands: [Legand] {
		if searchText.isEmpty {
			return legands
		} else {
			return legands.filter {$0.name.localizedCaseInsensitiveContains(searchText)}
		}
	}
}

struct ProteinListView_Previews: PreviewProvider {
	static var previews: some View {
		ProteinListView()

	}
}
