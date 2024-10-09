//
//  ImmersiveView.swift
//  BubblesMovesSmoothly
//
//  Created by Silvina Roldan on 02/10/2024.
//

import RealityKit
import SwiftUI
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel
    @State var predicate = QueryPredicate<Entity>.has(ModelComponent.self)
    @State private var timer: Timer?

    @State private var bubble = Entity()

    var body: some View {
        RealityView { content in
            
            if let immersiveContentEntity = try? await Entity(named: "BubbleScene", in: realityKitContentBundle) {
                bubble = immersiveContentEntity.findEntity(named: "Bubble")!
                for _ in 1...50 {
                    let bubbleClone = bubble.clone(recursive: true)
                    
                    guard var bubbleComponent = bubbleClone.components[BubbleComponent.self] else { return }
                    bubbleComponent.direction = [
                        Float.random(in: -1...1),
                        Float.random(in: -1...1),
                        Float.random(in: -1...1)
                    ]
                    bubbleClone.components[BubbleComponent.self] = bubbleComponent
                    
                    var physicsBody = PhysicsBodyComponent()
                    physicsBody.linearDamping = 0
                    physicsBody.isAffectedByGravity = false
                    
                    bubbleClone.components[PhysicsBodyComponent.self] = physicsBody
                    
                    var physicsMotions = PhysicsMotionComponent()
                    let linearVelocityX = Float.random(in: -0.05...0.05)
                    let linearVelocityY = Float.random(in: -0.05...0.05)
                    let linearVelocityZ = Float.random(in: -0.05...0.05)
                    
                    physicsMotions.linearVelocity = [linearVelocityX, linearVelocityY, linearVelocityZ]
                    
                    bubbleClone.components[PhysicsMotionComponent.self] = physicsMotions
                    
                    let x = Float.random(in: -1.5...1.5)
                    let y = Float.random(in: 1...1.5)
                    let z = Float.random(in: -1.5...1.5)

                    bubbleClone.position = [x, y, z]

                    content.add(bubbleClone)
                }
            }
        }
        .gesture(SpatialTapGesture().targetedToEntity(where: predicate).onEnded { value in
            let entity = value.entity
            guard var material = entity.components[ModelComponent.self]?.materials.first as? ShaderGraphMaterial else { return }
            let frameRate: TimeInterval = 1.0 / 60.0 // 60 frames per second
            let duration: TimeInterval = 0.25
            let targetValue: Float = 1
            let totalFrames = Int(duration / frameRate)

            // let animation = Animation.linear(duration: duration).repeatForever()

            var currentFrame = 0
            var popValue: Float = 0.0

            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: frameRate, repeats: true, block: { timer in
                currentFrame += 1
                let progress = Float(currentFrame) / Float(totalFrames)
                popValue = progress * targetValue
                do {
                    try material.setParameter(name: "Pop", value: .float(popValue))
                    entity.components[ModelComponent.self]?.materials = [material]
                } catch {
                    print("Error setting parameter: \(error)")
                }

                if currentFrame >= totalFrames {
                    timer.invalidate()
                    entity.removeFromParent()
                }
            })
        })
    }
}

#Preview(immersionStyle: .full) {
    ImmersiveView()
        .environment(AppModel())
}
