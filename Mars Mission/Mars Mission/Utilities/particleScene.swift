//
//  particleScene.swift
//  Mars Mission
//
//  Created by Aldrin Bahle Gama on 2020/11/21.
//

import Foundation
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        setupParticleEmitter()
    }
    
    private func setupParticleEmitter() {
        let particleEmitter = SKEmitterNode(fileNamed: "snowParticle")!
        particleEmitter.position = CGPoint(x: size.width, y: size.height - 50)
        addChild(particleEmitter)
    }
}
