//
//  ProteinsList.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 27.11.2022.
//

import Foundation

struct Protein: Hashable, Codable {
	var id: Int
	var name: String
}

class ProteinsList {
	var proteins: [Protein] = []

	init() {
		proteins = loadProteins()
	}

	func loadProteins() -> [Protein] {
		let filename: String = "ligands.txt"
		let data: String

		guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
		else {
			fatalError("Couldn't find \(filename) in main bundle.")
		}

		do {
			data = try String(contentsOf: file)
		} catch {
			fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
		}

		let proteinNames: [String] = data.components(separatedBy: .newlines).filter({$0 != ""})
		var tmpProteins: [Protein] = []
		for i in 0..<proteinNames.count {
			tmpProteins.append(Protein(id: i, name: proteinNames[i]))
		}
		return tmpProteins.sorted(by: {$0.name < $1.name})
	}
}
