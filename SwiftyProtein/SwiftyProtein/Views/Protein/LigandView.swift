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
	
	private let protein: Protein
	
	@StateObject private var ligandData: LigandLoader
	@State var pointer = UnsafeMutablePointer<SCNNode>.allocate(capacity: 1)
	@State var showAlert: Bool = false
	@State var selectedAtom: String = ""
	
	init(protein: Protein) {
		_ligandData = StateObject(wrappedValue: LigandLoader(protein: protein))
		self.protein = protein
		UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .darkGray
	}
	
	private var content: some View {
		Group {
			if ligandData.proteinFormula != nil && ligandData.ligandLoadingError == false {
				VStack {
					SceneKitView(
						scene: Ligand(atoms: ligandData.atomBlock, bonds: ligandData.bondBlock).scene,
						pointer: pointer,
						showAlert: $showAlert,
						selectedAtom: $selectedAtom
					)
					.alert("Selected atom: " + selectedAtom, isPresented: $showAlert) {
						Button("OK", role: .cancel) { showAlert.toggle() }
							.foregroundColor(.black)
					}
					Text(ligandData.proteinFormula!)
						.font(.system(size: 14, weight: .semibold, design: .rounded))
				}
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
		NavigationView {
			content
				.onAppear {
					ligandData.load()
				}
		}
		.navigationTitle(protein.name)
		.navigationBarItems(trailing: Button(action: shareProtein) {
			Image(systemName: "square.and.arrow.up")
		})
	}
	
	func shareProtein() {
		DispatchQueue.main.async {
			let render = SCNRenderer(device: MTLCreateSystemDefaultDevice())
			render.scene = Ligand(atoms: ligandData.atomBlock, bonds: ligandData.bondBlock).scene
			render.isTemporalAntialiasingEnabled = true
			render.isJitteringEnabled = true
			render.autoenablesDefaultLighting = true

			let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
			let image = render.snapshot(atTime: 0, with: size, antialiasingMode: .multisampling4X)
			let title = "Take a look at this ligand: \(ligandData.proteinFormula ?? "")"
			let activityVC = UIActivityViewController(activityItems: [title, image], applicationActivities: [])
			
			UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true)
		}
	}
}

struct LigandView_Previews: PreviewProvider {
	static var previews: some View {
		LigandView(protein: ProteinsList().proteins[0])
	}
}

