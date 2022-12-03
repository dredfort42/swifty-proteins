//
//  LigandLoader.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 03.12.2022.
//

import Foundation
import Combine

class LigandLoader: ObservableObject {
	@Published var ligandData: String?
	private let url: URL
	private var cancellabel: AnyCancellable?

	init(protein: Protein) {
		self.url = URL(string: "https://files.rcsb.org/ligands/view/\(protein.name.uppercased())_model.sdf")!
	}

	deinit {
		cancellabel?.cancel()
	}

	func load() {
		cancellabel = URLSession.shared.dataTaskPublisher(for: url)
			.map { String(data: $0.data, encoding: .utf8) }
			.replaceError(with: nil)
			.receive(on: DispatchQueue.main)
			.sink { [self] in ligandData = $0}
	}
}
