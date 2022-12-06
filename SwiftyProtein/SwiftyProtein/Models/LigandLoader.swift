//
//  LigandLoader.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 03.12.2022.
//

import Foundation
import Combine

class LigandLoader: ObservableObject {
	@Published var atomBlock: [Int : [String]] = [:]
	@Published var bondBlock: [Int : [String]] = [:]
	@Published var proteinFormula: String?

	private let url: URL
	private var cancellabel: AnyCancellable?
	private var ligandData: String?

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
			.sink { [self] in
				ligandData = $0
				getLigandData()
			}
	}

	func getLigandData(){
		let lines = ligandData?.components(separatedBy: .newlines)

		var i = 0
		var ab = 0
		var	bb = 0
		for line in lines! {
			if line.lengthOfBytes(using: .utf8) == 69 {
				atomBlock[ab] = line.components(separatedBy: .whitespaces).filter({ $0 != "" })
				ab += 1
			} else if line.lengthOfBytes(using: .utf8) == 21 {
				bondBlock[bb] = line.components(separatedBy: .whitespaces).filter({ $0 != "" })
				bb += 1
			} else if line == "> <FORMULA>" {
				proteinFormula = lines![i + 1]
				break
			}
			i += 1
		}
		print("----------")
		print(atomBlock)
		print("----------")
		print(bondBlock)
	}
}
