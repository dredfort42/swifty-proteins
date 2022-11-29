//
//  LegandView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 28.11.2022.
//

import SwiftUI

struct LegandView: View {
	var protein: Protein
    var body: some View {
		Text(protein.id.description + " - " + protein.name)
    }
}

struct LegandView_Previews: PreviewProvider {
    static var previews: some View {
        LegandView(protein: proteins[0])
    }
}
