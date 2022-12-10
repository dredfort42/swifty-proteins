//
//  Ligand.swift
//  SwiftyProtein
//
//  Created by Dmitry Novikov on 09.12.2022.
//

import Foundation
import SceneKit

class Ligand {
	var scene: SCNScene

	init(atoms: [Int : [String]], bonds: [Int : [String]]) {
		self.scene = SCNScene()

		scene.rootNode.addChildNode(getAmbientLightNode())
		scene.rootNode.addChildNode(getOmniLightNode())
		scene.rootNode.addChildNode(getAtomsNode(atoms: atoms))
		scene.rootNode.addChildNode(getBondsNode(atoms: atoms, bonds: bonds))
	}

	private func getAmbientLightNode() -> SCNNode {
		let ambientLight = SCNLight()
		ambientLight.type = SCNLight.LightType.ambient

		let ambientLightNode = SCNNode()
		ambientLightNode.light = ambientLight
		ambientLightNode.position = SCNVector3(x: 0, y: 0, z: 0)

		return ambientLightNode
	}

	private func getOmniLightNode() -> SCNNode {
		let omniLight = SCNLight()
		omniLight.type = SCNLight.LightType.omni

		let omniLightNode = SCNNode()
		omniLightNode.light = omniLight
		omniLightNode.position = SCNVector3(x: 1, y: 1, z: 1)

		return omniLightNode
	}

	private func getAtomsNode(atoms: [Int : [String]]) -> SCNNode {
		let atomsScene = SCNNode()

		for atom in atoms {
			let atomNode = SCNNode(geometry: SCNSphere(radius: 0.25))
			atomNode.position = SCNVector3(
				x: Float(atom.value[0]) ?? 0,
				y: Float(atom.value[1]) ?? 0,
				z: Float(atom.value[2]) ?? 0)
			atomNode.name = atom.value[3]
			atomNode.geometry?.firstMaterial?.lightingModel = .physicallyBased
			atomNode.geometry?.firstMaterial?.diffuse.contents = CPK.getColor(element: atom.value[3])
			atomNode.geometry?.firstMaterial?.metalness.contents = 0.75
			atomNode.geometry?.firstMaterial?.roughness.contents = 0.25
			atomsScene.addChildNode(atomNode)
		}

		return atomsScene
	}

	private func getBondsNode(atoms: [Int : [String]], bonds: [Int : [String]]) -> SCNNode {
		let bondsScene = SCNNode()

		for i in 0..<bonds.count {
			let firstAtomId = Int(bonds[i]![0])! - 1
			let secondAtomId = Int(bonds[i]![1])! - 1
			let firstAtomPosition = SCNVector3(
				x: Float(atoms[firstAtomId]![0])!,
				y: Float(atoms[firstAtomId]![1])!,
				z: Float(atoms[firstAtomId]![2])!)
			let secondAtomPosition = SCNVector3(
				x: Float(atoms[secondAtomId]![0])!,
				y: Float(atoms[secondAtomId]![1])!,
				z: Float(atoms[secondAtomId]![2])!)
			let bondPosition = SCNVector3(
				x: firstAtomPosition.x - secondAtomPosition.x,
				y: firstAtomPosition.y - secondAtomPosition.y,
				z: firstAtomPosition.z - secondAtomPosition.z)
			let bondHeight = sqrt(pow(bondPosition.x, 2) + pow(bondPosition.y, 2) + pow(bondPosition.z, 2))
			let bondNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: CGFloat(bondHeight)))
			bondNode.position = SCNVector3(
				x: (firstAtomPosition.x + secondAtomPosition.x) / 2,
				y: (firstAtomPosition.y + secondAtomPosition.y) / 2,
				z: (firstAtomPosition.z + secondAtomPosition.z) / 2)
			bondNode.eulerAngles = SCNVector3Make(
				Float(Double.pi/2),
				acos((secondAtomPosition.z - firstAtomPosition.z) / bondHeight),
				atan2(secondAtomPosition.y - firstAtomPosition.y, secondAtomPosition.x - firstAtomPosition.x))
			bondNode.geometry?.firstMaterial?.diffuse.contents = UIColor(white: 0.4, alpha: 1)
			bondNode.geometry?.firstMaterial?.metalness.contents = 0.75
			bondNode.geometry?.firstMaterial?.roughness.contents = 0.25
			bondsScene.addChildNode(bondNode)
		}

		return bondsScene
	}
}
