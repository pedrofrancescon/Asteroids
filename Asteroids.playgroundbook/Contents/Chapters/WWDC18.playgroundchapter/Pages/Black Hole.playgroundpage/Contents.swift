//#-hidden-code
import UIKit
import PlaygroundSupport
import SpriteKit
//#-end-hidden-code
/*:
 
 # Black Holes - The gravitational force
 
 On the previous page we played with *forces*, seeing how changing one object's mass can cause it to move fast or slowly.
 
 In this page we are going to explore a specific kind of *force*, following one more of the many discoveries of the great Isaac Newton, the **gravitational force**. This force is the responsible for pulling you back to the ground when you jump or for making an apple 🍎 fall from a tree, for example.
 
 Newton actually found out that this force is basically everywhere and makes all objects in the universe to attract one another with a really really weak force, unless the mass of one of the objects is really high (such as the Earth’s 🌎).
 
 One great example of something with extremely high mass that can be found in outer space is the **black hole**. Most of them are formed when a star ⭐️ is dying and they exert such a strong **gravitational force** that even light can’t escape from it! They are still in some ways a mystery, and some really clever and amazing people, such as the eternal Stephen Hawking, spent a great part of their lives studying it.
 
 In this page you also play with masses, although now you are going to be in control of a much higher mass, the mass of the **black hole** itself. One of the asteroids will have a force applied to it, and the other one will be still and will only move by the **gravitational force**.
 
 So, what are you waiting for? Make them blow!
 
 
 */
//#-hidden-code
import UIKit
import SpriteKit
import PlaygroundSupport

let frame = CGRect(x: 0, y: 0, width: 400, height: 600)

let view = SKView(frame: frame)

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true

let outerSpace = OuterSpace(size: frame.size)

let blackHole = GravitationalField(type: .blackHole, position: CGPoint(x: 200, y: 180), strength: 0.2, fallof: 0.1) //stellar

outerSpace.addChild(blackHole)

let brownAsteroid = Asteroid(position: CGPoint(x: 200, y: 500), color: .brown)
let greyAsteroid = Asteroid(position: CGPoint(x: 50, y: 400), color: .grey)

outerSpace.addChild(brownAsteroid)
outerSpace.addChild(greyAsteroid)

//#-end-hidden-code

blackHole.mass = /*#-editable-code*/2000/*#-end-editable-code*/
//#-hidden-code

greyAsteroid.force = CGVector(dx: 90.0, dy: 0.0)

let backgroundMusic = SKAudioNode(fileNamed: "background_music_2.m4a")
backgroundMusic.autoplayLooped = true

outerSpace.addChild(backgroundMusic)

view.presentScene(outerSpace)

//#-end-hidden-code

