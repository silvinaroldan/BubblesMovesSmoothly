//
//  BubblesSystem.swift
//  BubblesMovesSmoothly
//
//  Created by Silvina Roldan on 09/10/2024.
//

import RealityKit
import RealityKitContent

class BubblesSystem: System {
    private let query = EntityQuery(where: .has(BubbleComponent.self))
    private let speed: Float = 0.01
    
    required init(scene: Scene) {}
    
    func update(context: SceneUpdateContext) {
        let entities = context.entities(matching: query, updatingSystemWhen: .rendering)
        
        for bubble in entities {
            guard let bubbleComponent = bubble.components[BubbleComponent.self] else { return }
            
            bubble.position += bubbleComponent.direction * speed * Float(context.deltaTime)
        }
    }
}
