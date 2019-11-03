/*:
 # The Sun - Visualizing the orbital movement
 
 Well, you just experienced how bodies with extremely high mass (such as *black holes*) attract one another due to the *gravitational force*.
 
 But wait… if all the really heavy objects attract one another with a very strong force, how come the planets don't attract themselves and crash 💥 to one another in the middle of the outer space?
 
 Actually they do attract themselves. What happens is that a combination of other movements, along with the *gravitational force*, makes them move in circles around the object that has the higher mass in the solar system, the **Sun** ☀️ That movement is called **orbit**.
 
 A physician called Johannes Kepler, years before Newton’s discoveries, found out that the velocity that the planets orbit the sun is related to the distance they are from it. If a planet is really close to the Sun, it will move in circles really fast. On the other hand, if it is really far away from the Sun, it will take much more time to complete a circle.
 
 Okay, that is all you need to know for the final stage! Go for it!
 
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

let brownAsteroid = Asteroid(position: CGPoint(x: 200, y: 600), color: .brown)

let greyAsteroid = Asteroid(position: CGPoint(x: 200, y: 100), color: .grey)

outerSpace.addChild(brownAsteroid)
outerSpace.addChild(greyAsteroid)

var distanceFromSun: CGFloat = 50.0

//#-end-hidden-code

//Great values are between 1000 ans 2000
distanceFromSun = /*#-editable-code*/1600/*#-end-editable-code*/

//#-hidden-code

var distance = distanceFromSun / 14.28

if distance < 70 {
    distance = 70
} else if distance > 150 {
    distance = 150
}

let sun = GravitationalField.init(type: .sun, position: CGPoint(x: 200.0, y: 430.0), strength: 0.1)
outerSpace.addChild(sun)

brownAsteroid.position.y = sun.position.y + distance

let forceX = -(0.0033 * pow(distance, 2.0) - 1.035 * distance + 128.5) // computationally modeled equation

brownAsteroid.force = CGVector(dx: forceX, dy: 0)
greyAsteroid.force = CGVector(dx: 0.0, dy: 55.0)

let backgroundMusic = SKAudioNode(fileNamed: "background_music_3.m4a")
backgroundMusic.autoplayLooped = true

outerSpace.addChild(backgroundMusic)

view.presentScene(outerSpace)

//#-end-hidden-code
