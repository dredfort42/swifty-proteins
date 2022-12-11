//
//  SceneKitView.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 10.12.2022.
//

import SwiftUI
import SceneKit

struct SceneKitView: UIViewRepresentable {
	var view = SCNView()
	var scene: SCNScene
	var pointer: UnsafeMutablePointer<SCNNode>

	@Binding var showAlert: Bool
	@Binding var selectedAtom: String

	init(scene: SCNScene, pointer: UnsafeMutablePointer<SCNNode>, showAlert: Binding<Bool>, selectedAtom: Binding<String>) {
		self.scene = scene
		self.pointer = pointer
		view.scene = self.scene
		view.allowsCameraControl = true
		view.isUserInteractionEnabled = true
		view.isTemporalAntialiasingEnabled = true
		view.antialiasingMode = .multisampling4X
		self._showAlert = showAlert
		self._selectedAtom = selectedAtom
	}
	
	class Coordinator: NSObject {
		@Binding var showAlert: Bool
		@Binding var selectedAtom: String

		init(showAlert: Binding<Bool>, selectedAtom: Binding<String>) {
			self._showAlert = showAlert
			self._selectedAtom = selectedAtom
		}

		@objc func tapGesture(tap: UITapGestureRecognizer) {
			if tap.state == .ended {
				let tapView = tap.view as! SCNView
				let tapLocation = tap.location(in: tapView)
				let tapHit = tapView.hitTest(tapLocation, options: nil)

				if let atom = tapHit.first?.node {
					showAlert.toggle()
					selectedAtom = atom.name ?? ""
				}

			}
		}
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(showAlert: $showAlert, selectedAtom: $selectedAtom)
	}

	func makeUIView(context: Context) -> SCNView {
		let scnView = self.view
		let gestureRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.tapGesture(tap:)))
		scnView.addGestureRecognizer(gestureRecognizer)
		return scnView
	}

	func updateUIView(_ scnView: SCNView, context: Context) { }
}
