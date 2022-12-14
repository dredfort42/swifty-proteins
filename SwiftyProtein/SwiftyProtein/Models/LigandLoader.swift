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
	@Published var ligandLoadingError: Bool

	private let url: URL
	private var cancellabel: AnyCancellable?
	private var ligandData: String?

	init(protein: Protein) {
		ligandLoadingError = false
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
			.sink(receiveCompletion: { (suscriberCompletion) in
				switch suscriberCompletion {
					case .finished:
						if self.ligandData == nil {
							self.ligandLoadingError = true
						} else {
							self.getLigandData()
							if self.proteinFormula == nil {
								self.ligandLoadingError = true
							}
						}
					case .failure(let error):
						self.ligandLoadingError = true
						print("Ligand loading error: \(error.localizedDescription)")
				}
			}, receiveValue: { [weak self] (rawData) in
				self?.ligandData = rawData
			})
	}

	private func getLigandData(){
		let lines = ligandData!.components(separatedBy: .newlines)
		var ab = 0
		var	bb = 0
		
		for i in 0..<lines.count {
			if lines[i].lengthOfBytes(using: .utf8) == 69 {
				atomBlock[ab] = lines[i].components(separatedBy: .whitespaces).filter({ $0 != "" })
				ab += 1
			} else if lines[i].lengthOfBytes(using: .utf8) == 21 {
				bondBlock[bb] = lines[i].components(separatedBy: .whitespaces).filter({ $0 != "" })
				bb += 1
			} else if lines[i] == "> <FORMULA>" {
				proteinFormula = lines[i + 1]
				break
			}
		}
	}
}
