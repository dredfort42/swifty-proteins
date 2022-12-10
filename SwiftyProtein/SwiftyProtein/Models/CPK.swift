//
//  CPK.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 08.12.2022.
//

import Foundation
import SwiftUI

class CPK {
	private static let colors: [String : Color] = [
		"H" : Color(white: 0.8),
		"C" : Color(white: 0.0),
		"N" : .blue,
		"O" : .red,
		"F" : .green,
		"Cl" : .green,
		"Br" : Color(red: 0.55, green: 0, blue: 0),
		"I" : Color(red: 0.58, green: 0, blue: 0.83),
		"He" : .cyan,
		"Ne" : .cyan,
		"Ar" : .cyan,
		"Kr" : .cyan,
		"Xe" : .cyan,
		"P" : .orange,
		"S" : .yellow,
		"B" : Color(red: 0.77, green: 0.71, blue: 0.64),
		"Li" : Color(red: 0.43, green: 0, blue: 0.75),
		"Na" : Color(red: 0.43, green: 0, blue: 0.75),
		"K" : Color(red: 0.43, green: 0, blue: 0.75),
		"Rb" : Color(red: 0.43, green: 0, blue: 0.75),
		"Cs" : Color(red: 0.43, green: 0, blue: 0.75),
		"Fr" : Color(red: 0.43, green: 0, blue: 0.75),
		"Be" : Color(red: 0, green: 0.39, blue: 0),
		"Mg" : Color(red: 0, green: 0.39, blue: 0),
		"Ca" : Color(red: 0, green: 0.39, blue: 0),
		"Sr" : Color(red: 0, green: 0.39, blue: 0),
		"Ba" : Color(red: 0, green: 0.39, blue: 0),
		"Ra" : Color(red: 0, green: 0.39, blue: 0),
		"Ti" : Color(white: 0.6),
		"Fe" : Color(red: 1, green: 0.55, blue: 0),
	]

	public static func getColor(element: String) -> UIColor {
		if let _ = colors[element] {
			return UIColor(colors[element]!)
		} else {
			return UIColor(.pink)
		}
	}
}
