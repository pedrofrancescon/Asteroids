import PlaygroundSupport
import Foundation
import UIKit
import SpriteKit

public enum AsteroidColor {
    case brown, grey
}

public class Asteroid: SKSpriteNode {
    
    public var force: CGVector! {
        didSet {
            
            physicsBody?.fieldBitMask = 0x0
            
            run(SKAction.wait(forDuration: 0.35), completion: {
                
                self.applyImpulse(to: self.physicsBody!, with: self.force)
                
                self.physicsBody?.fieldBitMask = 0xF
                
            })
        }
    }
    
    public var mass: CGFloat! {
        didSet {
            physicsBody?.mass = mass
        }
    }
    
    public override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        physicsBody = SKPhysicsBody(texture: self.texture!, size: self.size)
        
        physicsBody?.linearDamping = 0.0
        physicsBody?.angularDamping = 0.0
        physicsBody?.mass = 1.0
        physicsBody?.contactTestBitMask = 0xF
        physicsBody?.collisionBitMask = 0xF
        
        name = "asteroid"
    }
    
    
    public convenience init(position: CGPoint, color: AsteroidColor) {
        
        switch color {
        case .brown:
            self.init(texture: SKTexture(imageNamed: "brown_asteroid.png"), color: .clear, size: CGSize(width: 30, height: 30))
        case .grey:
            self.init(texture: SKTexture(imageNamed: "grey_asteroid.png"), color: .clear, size: CGSize(width: 30, height: 30))
        }
        
        
        self.position = position
    }
    
    func applyImpulse(to body: SKPhysicsBody, with force: CGVector) {
        guard let explosion = SKEmitterNode(fileNamed: "impulse") else { return }
        
        var tan: CGFloat = 0.0
        
        tan = (force.dy + 0.00001) / (force.dx + 0.00001)
        
        let arctg = atan(tan)
        
        let pi: CGFloat = force.dx < 0.0 ? 0.0 : .pi
        
        explosion.emissionAngle = arctg + pi
        
        explosion.position = self.position
        explosion.zPosition = -0.1
        
        self.scene?.addChild(explosion)
        
        body.applyImpulse(force)
        body.angularVelocity = CGFloat(3 * drand48())
        
        let impulseSound = SKAction.playSoundFileNamed("impulse_sound.m4a", waitForCompletion: false)
        run(impulseSound)
        
        run(SKAction.wait(forDuration: 0.25), completion: {
            explosion.particleBirthRate = 0.0
        })
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
