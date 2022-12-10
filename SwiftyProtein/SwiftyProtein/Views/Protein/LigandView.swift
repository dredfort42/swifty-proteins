//
//  LigandView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 28.11.2022.
//

import SwiftUI
import SceneKit

struct LigandView: View {
	@Environment(\.dismiss) var dismiss

	@StateObject private var ligandData: LigandLoader
	private let protein: Protein

	init(protein: Protein) {
		_ligandData = StateObject(wrappedValue: LigandLoader(protein: protein))
		self.protein = protein
	}

//	var cameraNode: SCNNode? {
//		let cameraNode = SCNNode()
//		cameraNode.camera = SCNCamera()
//		cameraNode.position = SCNVector3(x: 0, y: 0, z: 2)
//		return cameraNode
//	}



	private var content: some View {
		Group {
			if ligandData.proteinFormula != nil && ligandData.ligandLoadingError == false {
				NavigationView {
//					Text(ligandData.proteinFormula!)

					SceneView(
						scene: Ligand(atoms: ligandData.atomBlock, bonds: ligandData.bondBlock).scene,
//						pointOfView: cameraNode,
						options: [
							.allowsCameraControl,
							.autoenablesDefaultLighting,
							.temporalAntialiasingEnabled
						]
					)
				}
				.navigationTitle(ligandData.proteinFormula!)
			} else {
				Image(systemName: "hourglass")
					.font(.system(size: 42, weight: .thin))
					.foregroundColor(Color(white: 0.50))
					.background(
						SpinningWheelView(wheelSize: 120.0, wheelAnimation: true)
					)
			}
		}
		.alert(isPresented: $ligandData.ligandLoadingError) {
			Alert(title: Text(protein.name.uppercased()),
				  message: Text("Ligand loading error"),
				  dismissButton: .default(
					Text("Back to proteins"),
					action: { dismiss() }
				  )
			)
		}
	}

	var body: some View {
		content
			.onAppear {
				ligandData.load()
			}
	}
}

struct LigandView_Previews: PreviewProvider {
	static var previews: some View {
		LigandView(protein: ProteinsList().proteins[0])
	}
}

