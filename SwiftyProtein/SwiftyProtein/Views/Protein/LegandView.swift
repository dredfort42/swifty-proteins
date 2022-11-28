//
//  LegandView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 28.11.2022.
//

import SwiftUI

struct LegandView: View {
	var legand: Legand
    var body: some View {
		Text(legand.id.description + " - " + legand.name)
    }
}

struct LegandView_Previews: PreviewProvider {
    static var previews: some View {
        LegandView(legand: legands[0])
    }
}
