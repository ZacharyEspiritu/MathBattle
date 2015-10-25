//
//  MainScene.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Zachary Espiritu. All rights reserved.
//

import Foundation

class MainScene: CCNode {
    
    // MARK: Functions
    
    /**
    Called whenever the `MainScene.ccb` is loaded.
    */
    func didLoadFromCCB() {
        OALSimpleAudio.sharedInstance().playBg("Rhinoceros.mp3", loop: true)
    }
    
    /**
    Begins the game.
    */
    func play() {
        Mixpanel.sharedInstance().track("Round Started")
        let gameplayScene = CCBReader.load("Gameplay") as! Gameplay
        
        let scene = CCScene()
        scene.addChild(gameplayScene)
        
        let transition = CCTransition(fadeWithDuration: 0.5)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
}