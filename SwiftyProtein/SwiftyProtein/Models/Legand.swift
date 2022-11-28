//
//  Legand.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 27.11.2022.
//

import Foundation

struct Legand: Hashable, Codable {
	var id: Int
	var name: String
}

var legands: [Legand] = loadLegands()

func loadLegands() -> [Legand] {
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

	let legandNames: [String] = data.components(separatedBy: .newlines).filter({$0 != ""})
	var tmpLegands: [Legand] = []
	for i in 0..<legandNames.count {
		tmpLegands.append(Legand(id: i, name: legandNames[i]))
	}
	print(tmpLegands)
	return tmpLegands.sorted(by: {$0.name < $1.name})
}
