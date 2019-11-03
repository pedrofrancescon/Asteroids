import Foundation
import UIKit
import PlaygroundSupport
import SpriteKit

public class OuterSpace: SKScene, SKPhysicsContactDelegate {
    
    override public init(size: CGSize) {
        super.init(size: size)
        
        //no gravity!
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        
        backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 65 / 255, alpha: 1.0)
        
        //creates a sky full of stars
        for _ in 0..<300 {
            
            let star = SKShapeNode(circleOfRadius: CGFloat(drand48()))
            star.fillColor = .white
            star.position.x = CGFloat(arc4random_uniform(401))
            star.position.y = CGFloat(arc4random_uniform(601))
            
            addChild(star)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateRemoval(of asteroid: SKNode, by gravitationalField: SKNode){
        //the asteroid is shrnked to 0 like it was swallowed by the gravitaional field
        let shrink = SKAction.scale(to: 0.0, duration: 0.3)
        let move = SKAction.move(to: gravitationalField.position, duration: 0.3)
        
        let actions = SKAction.group([shrink, move])
        
        asteroid.run(actions) {
            asteroid.removeFromParent()
        }
    }
    
    /*
     Handles all kinds of collisions that may happen in the outer space
    */
    public func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        //if the collision is between two asteroids...
        if (nodeA.name == "asteroid") && (nodeB.name == "asteroid") {
            
            //they explode so bye bye they are removed from the scene
            nodeA.removeFromParent()
            nodeB.removeFromParent()
            
            guard let explosion = SKEmitterNode(fileNamed: "explosion") else { return }
            //positioning the explosion animation between the two asteroids
            explosion.position.x = (nodeA.position.x + nodeB.position.x) / 2
            explosion.position.y = (nodeA.position.y + nodeB.position.y) / 2
            addChild(explosion)
            
            let winningSound = SKAction.playSoundFileNamed("winning_sound.m4a", waitForCompletion: false)
            run(winningSound)
            
            run(SKAction.wait(forDuration: 0.2), completion: {
                explosion.particleBirthRate = 0.0
            })
          
        //if any of the two colliding objects is a gravitational field....
        } else if nodeA.name == "gravitationalField" {
            animateRemoval(of: nodeB, by: nodeA)
        } else if nodeB.name == "gravitationalField" {
            animateRemoval(of: nodeA, by: nodeB)
        }
    }
}


