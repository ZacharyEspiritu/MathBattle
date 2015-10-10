//
//  Gameplay.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class Gameplay: CCNode {
    
    weak var bottomGrid: Grid!
    var bottomTiles: [Tile] = []
    weak var topGrid: Grid!
    var topTiles: [Tile] = []
    
    weak var world: CCNode!
    
    weak var topEquation, bottomEquation: CCLabelTTF!
    var topChosenSet: [Values] = []
    weak var topTarget, bottomTarget: CCLabelTTF!
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
        
        bottomGrid.spawnNewTiles()
        topGrid.spawnNewTiles()
        
        countdownBeforeGameBegins()
    }
    
    func generateNewRound() {
        let potentialTargetNumbers: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,20,21,22,24,25,26,27,28,30,32,33,34,35,36,38,40,42,44,45,46,48,50,52,54,55,56,58,60,62,63,64]
        
        let targetNumber = potentialTargetNumbers[Int(arc4random_uniform(UInt32(potentialTargetNumbers.count)))]
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
    
    func tilePressed(value: Values, side: Side, tile: Tile) {
        if side == .Bottom {
            bottomChosenSet.append(value)
            if bottomEquation.string == nil {
                bottomEquation.string = "\(value.rawValue)"
            }
            else {
                bottomEquation.string = "\(bottomEquation.string) \(value.rawValue)"
            }
        }
        else {
            topChosenSet.append(value)
            if topEquation.string == nil {
                topEquation.string = "\(value.rawValue)"
            }
            else {
                topEquation.string = "\(topEquation.string) \(value.rawValue)"
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
}