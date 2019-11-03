/*:
 
 # Asteroids - The understanding of forces
 
 
 One of the most important parts and goals of physics is the study of motion and what can cause an object to move. It is present in almost every situation you can imagine, from walking 🚶🏻‍♂️ to the takeoff of an airplane ✈️ or the span of a shooting star 💫
 
 That cause is called **force**, which is basically a push or pull on an object.
 
 The relation between a force and the movement it causes was first understood by the legendary physician Isaac Newton, who said that a **force** can make an object move fast or slowly, depending on its mass.
 
 
 That being said, I introduce you to a game where your main goal is to basically make some gigantic galactic rocks collide, the so called **asteroids** ☄️ An unknown force is applied to each one of them and you will have the power to change their masses and, consequently, how fast they move.
 
 Oh, also, the game is played in outer space 🚀 so that we can guarantee there is no other force being exerted other than ours (it is a standard when studying physics, you know).
 
 
 Without further ado, let’s get to it!
 
 *(Hit the play button and see what happens)*
 
 
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

let brownAsteroid = Asteroid(position: CGPoint(x: 40, y: 550), color: .brown)

let greyAsteroid = Asteroid(position: CGPoint(x: 40, y: 130), color: .grey)

outerSpace.addChild(brownAsteroid)
outerSpace.addChild(greyAsteroid)

//#-end-hidden-code

brownAsteroid.mass = /*#-editable-code*/100/*#-end-editable-code*/

greyAsteroid.mass = /*#-editable-code*/100/*#-end-editable-code*/

//#-hidden-code

brownAsteroid.force = CGVector(dx: 4000.0, dy: -5200.0)
greyAsteroid.force = CGVector(dx: 7700.0, dy: 10000.0)

let backgroundMusic = SKAudioNode(fileNamed: "background_music.m4a")
backgroundMusic.autoplayLooped = true

outerSpace.addChild(backgroundMusic)

view.presentScene(outerSpace)

//#-end-hidden-code
