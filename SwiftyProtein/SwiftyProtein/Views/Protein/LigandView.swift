//
//  LigandView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 28.11.2022.
//

import SwiftUI

struct LigandView: View {
	var protein: Protein
    var body: some View {
		Text(protein.id.description + " - " + protein.name)
    }
}

struct LigandView_Previews: PreviewProvider {
    static var previews: some View {
        LigandView(protein: proteins[0])
    }
}


//https://download.rcsb.org/batch/ccd/001_model.sdf
