//
//  Gameplay.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

enum Operation: String {
    case Add = " + "
    case Subtract = " - "
    case Multiply = " × "
}

class Gameplay: CCNode {
    
    weak var bottomGrid: Grid!
    var bottomTiles: [Tile] = []
    weak var topGrid: Grid!
    var topTiles: [Tile] = []
    
    weak var grayOut: CCNodeColor!
    weak var bottomWinLabel: CCLabelTTF!
    weak var topWinLabel: CCLabelTTF!
    weak var playAgain: CCButton!
    
    weak var world: CCNode!
    
    weak var topEquation, bottomEquation: CCLabelTTF!
    var topChosenSet: [Values] = []
    weak var topTarget, bottomTarget: CCLabelTTF!
    var topTargetNumber: Int = 0 {
        didSet {
            topTarget.string = "\(topTargetNumber)"
        }
    }
    var bottomTargetNumber: Int = 0 {
        didSet {
            bottomTarget.string = "\(bottomTargetNumber)"
        }
    }
    var bottomChosenSet: [Values] = []
    
    weak var topCountdown, bottomCountdown: CCLabelTTF!
    var countdown: String = "" {
        didSet {
            topCountdown.string = countdown
            bottomCountdown.string = countdown
        }
    }
    
    func didLoadFromCCB() {
        self.userInteractionEnabled = true
        self.multipleTouchEnabled = true
        
        bottomGrid.side = .Bottom
        topGrid.side = .Top
        
        bottomGrid.delegate = self
        topGrid.delegate = self
        
        bottomTargetNumber = bottomGrid.generateNewRound()
        topTargetNumber = topGrid.generateNewRound()

        countdownBeforeGameBegins()
    }
    
    func countdownBeforeGameBegins() {
        topCountdown.visible = true
        bottomCountdown.visible = true
        
        self.countdown = "Ready?"
        delay(1.2) {
            self.countdown = "3"
            self.delay(1) {
                self.countdown = "2"
                self.delay(1) {
                    self.countdown = "1"
                    self.delay(1) {
                        self.animationManager.runAnimationsForSequenceNamed("GameStart")
                        // Enable user interaction on "GO!".
                        self.countdown = "GO!"
                        self.userInteractionEnabled = true
                        self.multipleTouchEnabled = true
                        self.delay(0.4) {
                            // Remove the "GO!" after a slight pause. No need to wait another full second since the players will already know what to do.
                            self.topCountdown.visible = false
                            self.bottomCountdown.visible = false
                            return
                        }
                    }
                }
            }
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

extension Gameplay: GridDelegate {
    
    func tilePressed(string: String, side: Side, tile: Tile) {
        if side == .Bottom {
            bottomChosenSet.append(tile.value)
            if bottomEquation.string == nil {
                bottomEquation.string = "\(string)"
            }
            else {
                if bottomChosenSet.count == 3 || bottomChosenSet.count == 5 || bottomChosenSet.count == 7 {
                    bottomEquation.string = "(\(bottomEquation.string)\(string))"
                }
                else {
                    bottomEquation.string = "\(bottomEquation.string)\(string)"
                }
            }
        }
        else {
            topChosenSet.append(tile.value)
            if topEquation.string == nil {
                topEquation.string = "\(string)"
            }
            else {
                if topChosenSet.count == 3 || topChosenSet.count == 5 || topChosenSet.count == 7 {
                    topEquation.string = "(\(topEquation.string)\(string))"
                }
                else {
                    topEquation.string = "\(topEquation.string)\(string)"
                }
            }
        }
    }
    
    func clear(side: Side) {
        if side == .Bottom {
            bottomChosenSet.removeAll()
            bottomEquation.string = ""
        }
        else {
            topChosenSet.removeAll()
            topEquation.string = ""
        }
    }
    
    func solve(side: Side) {
        if side == .Bottom {
            if bottomChosenSet.count == 9 {
                if bottomChosenSet[0].rawValue >= 0 && bottomChosenSet[2].rawValue >= 0 && bottomChosenSet[4].rawValue >= 0 && bottomChosenSet[6].rawValue >= 0 && bottomChosenSet[8].rawValue >= 0 && bottomChosenSet[1].rawValue < 0 && bottomChosenSet[3].rawValue < 0 && bottomChosenSet[5].rawValue < 0 && bottomChosenSet[7].rawValue < 0 {
                    print("valid")
                    
                    var supposedTarget = bottomChosenSet[0].rawValue
                    switch bottomChosenSet[1].rawValue {
                    case -1:
                        supposedTarget += bottomChosenSet[2].rawValue
                    case -2:
                        supposedTarget -= bottomChosenSet[2].rawValue
                    case -3:
                        supposedTarget *= bottomChosenSet[2].rawValue
                    default: break
                    }
                    switch bottomChosenSet[3].rawValue {
                    case -1:
                        supposedTarget += bottomChosenSet[4].rawValue
                    case -2:
                        supposedTarget -= bottomChosenSet[4].rawValue
                    case -3:
                        supposedTarget *= bottomChosenSet[4].rawValue
                    default: break
                    }
                    switch bottomChosenSet[5].rawValue {
                    case -1:
                        supposedTarget += bottomChosenSet[6].rawValue
                    case -2:
                        supposedTarget -= bottomChosenSet[6].rawValue
                    case -3:
                        supposedTarget *= bottomChosenSet[6].rawValue
                    default: break
                    }
                    switch bottomChosenSet[7].rawValue {
                    case -1:
                        supposedTarget += bottomChosenSet[8].rawValue
                    case -2:
                        supposedTarget -= bottomChosenSet[8].rawValue
                    case -3:
                        supposedTarget *= bottomChosenSet[8].rawValue
                    default: break
                    }
                    
                    if supposedTarget == bottomTargetNumber {
                        completedPuzzle(.Bottom)
                    }
                    else {
                        bottomGrid.animationManager.runAnimationsForSequenceNamed("Incorrect")
                    }
                }
                else {
                    bottomGrid.animationManager.runAnimationsForSequenceNamed("Incorrect")
                }
            }
            else {
                bottomGrid.animationManager.runAnimationsForSequenceNamed("Incorrect")
            }
        }
        else {
            if topChosenSet.count == 9 {
                if topChosenSet[0].rawValue >= 0 && topChosenSet[2].rawValue >= 0 && topChosenSet[4].rawValue >= 0 && topChosenSet[6].rawValue >= 0 && topChosenSet[8].rawValue >= 0 && topChosenSet[1].rawValue < 0 && topChosenSet[3].rawValue < 0 && topChosenSet[5].rawValue < 0 && topChosenSet[7].rawValue < 0 {
                    print("valid")
                    
                    var supposedTarget = topChosenSet[0].rawValue
                    switch topChosenSet[1].rawValue {
                    case -1:
                        supposedTarget += topChosenSet[2].rawValue
                    case -2:
                        supposedTarget -= topChosenSet[2].rawValue
                    case -3:
                        supposedTarget *= topChosenSet[2].rawValue
                    default: break
                    }
                    switch topChosenSet[3].rawValue {
                    case -1:
                        supposedTarget += topChosenSet[4].rawValue
                    case -2:
                        supposedTarget -= topChosenSet[4].rawValue
                    case -3:
                        supposedTarget *= topChosenSet[4].rawValue
                    default: break
                    }
                    switch topChosenSet[5].rawValue {
                    case -1:
                        supposedTarget += topChosenSet[6].rawValue
                    case -2:
                        supposedTarget -= topChosenSet[6].rawValue
                    case -3:
                        supposedTarget *= topChosenSet[6].rawValue
                    default: break
                    }
                    switch topChosenSet[7].rawValue {
                    case -1:
                        supposedTarget += topChosenSet[8].rawValue
                    case -2:
                        supposedTarget -= topChosenSet[8].rawValue
                    case -3:
                        supposedTarget *= topChosenSet[8].rawValue
                    default: break
                    }
                    
                    if supposedTarget == topTargetNumber {
                        completedPuzzle(.Top)
                    }
                    else {
                        topGrid.animationManager.runAnimationsForSequenceNamed("Incorrect")
                    }
                }
                else {
                    topGrid.animationManager.runAnimationsForSequenceNamed("Incorrect")
                }
            }
            else {
                topGrid.animationManager.runAnimationsForSequenceNamed("Incorrect")
            }
        }
    }
    
    func completedPuzzle(winner: Side) {
        if winner == .Top {
            topGrid.removeAllTiles()
            topGrid.increaseScore()
            topChosenSet.removeAll()
            if topGrid.puzzlesRemaining == 0 {
                gameEnd(.Top)
            }
            else {
                delay(0.5) {
                    self.topTargetNumber = self.topGrid.generateNewRound()
                    self.topEquation.string = ""
                }
            }
        }
        else if winner == .Bottom {
            bottomGrid.removeAllTiles()
            bottomGrid.increaseScore()
            bottomChosenSet.removeAll()
            if bottomGrid.puzzlesRemaining == 0 {
                gameEnd(.Bottom)
            }
            else {
                delay(0.5) {
                    self.bottomTargetNumber = self.bottomGrid.generateNewRound()
                    self.bottomEquation.string = ""
                }
            }
        }
    }
    
    func gameEnd(winner: Side) {
        userInteractionEnabled = false
        multipleTouchEnabled = false
        
        if winner == .Top {
            bottomGrid.breakTiles()
            bottomWinLabel.string = "you lose."
        }
        else {
            topGrid.breakTiles()
            topWinLabel.string = "you lose."
        }
        delay(1) {
            self.playAgain.position = ccp(0.5, 0.5)
            self.grayOut.runAction(CCActionFadeTo(duration: 0.5, opacity: 0.6))
            self.playAgain.runAction(CCActionFadeTo(duration: 0.5, opacity: 1))
            self.bottomWinLabel.runAction(CCActionFadeTo(duration: 0.5, opacity: 1))
            self.topWinLabel.runAction(CCActionFadeTo(duration: 0.5, opacity: 1))
        }
    }
    
    func again() {
        let gameplayScene = CCBReader.load("Gameplay") as! Gameplay
        
        let scene = CCScene()
        scene.addChild(gameplayScene)
        
        let transition = CCTransition(fadeWithDuration: 0.5)
        CCDirector.sharedDirector().presentScene(scene, withTransition: transition)
    }
    
}