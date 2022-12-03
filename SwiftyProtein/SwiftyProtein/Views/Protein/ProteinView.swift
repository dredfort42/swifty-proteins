//
//  ProteinView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 03.12.2022.
//

import SwiftUI

struct ProteinView: View {
	var protein: Protein
	
	var body: some View {
		LigandView(protein: protein)
	}
}

struct ProteinView_Previews: PreviewProvider {
	static var previews: some View {
		ProteinView(protein: ProteinsList().proteins[0])
	}
}
