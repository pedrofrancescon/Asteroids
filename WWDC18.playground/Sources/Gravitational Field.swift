import Foundation
import UIKit
import PlaygroundSupport
import SpriteKit

public enum GravitationalFieldType {
    case blackHole, sun
}

public class GravitationalField: SKNode {
    
    let field = SKFieldNode.radialGravityField()
    
    public var mass: Float! {
        didSet {
            //Newton's Law: the strenth of a body's gravitational field is related to it's mass
            field.strength = mass / 10000.0
        }
    }
    
    public override init() {
        super.init()
    }
    
    public convenience init(type: GravitationalFieldType,
                            position: CGPoint,
                            strength: Float,
                            fallof: Float = 2.0,
                            region: SKRegion = SKRegion.infinite()) {
        self.init()
        
        name = "gravitationalField"
        
        self.position = position
        field.strength = strength
        field.falloff = fallof
        field.region = region
        
        physicsBody = SKPhysicsBody(circleOfRadius: 30.0)
        //those are to guarantee the gravitational fields do not behave like solid colliding objects like rocks
        physicsBody?.contactTestBitMask = 0xFFFFFFFF
        physicsBody?.collisionBitMask = 0x00000000
        
        //creates circles of different colors and sizes to illustrate the black hole and the sun :)
        switch type {
        case .blackHole:
            
            let blackHole = SKShapeNode(circleOfRadius: 30.0)
            blackHole.position = CGPoint(x: 0.0, y: 0.0)
            blackHole.fillColor = .white
            blackHole.glowWidth = 10.0
            addChild(blackHole)
            animate(blackHole)
            
            let blackCircle = SKShapeNode(circleOfRadius: 30.0)
            blackCircle.position = CGPoint(x: 0.0, y: 0.0)
            blackCircle.fillColor = .black
            blackCircle.glowWidth = 2.0
            addChild(blackCircle)
            
        case .sun:
            
            let orangeSun = SKShapeNode(circleOfRadius: 40.0)
            orangeSun.position = CGPoint(x: 0.0, y: 0.0)
            orangeSun.fillColor = UIColor(red: 1.0, green: 150.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
            orangeSun.strokeColor = UIColor(red: 1.0, green: 150.0 / 255.0, blue: 5.0 / 255.0, alpha: 1.0)
            orangeSun.glowWidth = 20.0
            addChild(orangeSun)
            animate(orangeSun)
            
            let yellowSun = SKShapeNode(circleOfRadius: 30.0)
            yellowSun.position = CGPoint(x: 0.0, y: 0.0)
            yellowSun.fillColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
            yellowSun.strokeColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
            yellowSun.glowWidth = 15.0
            addChild(yellowSun)
        }
        
        addChild(field)
        
    }
    
    //scaling movements just to give some life to the scene :)
    func animate(_ node: SKShapeNode) {
        let upScale = SKAction.scale(to: 1.1, duration: 1.8)
        let downScale = SKAction.scale(to: 0.98, duration: 1.8)
        let actions = SKAction.sequence([upScale, downScale])
        node.run(SKAction.repeatForever(actions))
    }
    
    //no fatal occasions in this code other than being swallowed by black holes
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

