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
            /* we are cheating physics here, the asteroid will not be affected
             by any gravitational field until we are done setting things up */
            physicsBody?.fieldBitMask = 0x0
            
            run(SKAction.wait(forDuration: 0.35), completion: {
                self.applyImpulse(to: self.physicsBody!, with: self.force)
                //now physics and attractions are back to normal
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
        //here we say: they can move arround and rotate freely, without any friction or resistance
        physicsBody?.linearDamping = 0.0
        physicsBody?.angularDamping = 0.0
        physicsBody?.mass = 1.0
        //and here we allow them to collide to each other
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
        guard let tail = SKEmitterNode(fileNamed: "impulse") else { return }
        
        /* all that is to make the white tail of the asteroid flow backwards,
         in the opposite direction of the asteroid's movement */
        var tan: CGFloat = 0.0
        tan = (force.dy + 0.00001) / (force.dx + 0.00001)
        let arctg = atan(tan)
        let pi: CGFloat = force.dx < 0.0 ? 0.0 : .pi
        tail.emissionAngle = arctg + pi
        
        //positioning the tale baehind the asteroid
        tail.position = self.position
        tail.zPosition = -0.1
        
        self.scene?.addChild(tail)
        
        body.applyImpulse(force)
        //here we make the asteroid rotate a little bit, it kind of feels more natural this way
        body.angularVelocity = CGFloat(3 * drand48())
        
        // there are no sounds in the real outer space, I know...
        let impulseSound = SKAction.playSoundFileNamed("impulse_sound.m4a", waitForCompletion: false)
        run(impulseSound)
        
        //let the animation begin!
        run(SKAction.wait(forDuration: 0.25), completion: {
            tail.particleBirthRate = 0.0
        })
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
