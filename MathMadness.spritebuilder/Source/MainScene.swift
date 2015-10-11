import Foundation

class MainScene: CCNode {
    
    func didLoadFromCCB() {
        OALSimpleAudio.sharedInstance().playBg("Rhinoceros.mp3", loop: true)
    }
    
    func play() {
        let gameplayScene = CCBReader.load("Gameplay") as! Gameplay
        
        let scene = CCScene()
        scene.addChild(gameplayScene)
        
        let transition = CCTransition(fadeWithDuration: 0.5)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }

}
