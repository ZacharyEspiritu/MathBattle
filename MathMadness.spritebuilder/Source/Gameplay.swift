//
//  Gameplay.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

enum Operation {
    case Add, Subtract, Multiply
}

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
        var targetNumber: Int = 0
        
        let firstNumber = Int(arc4random_uniform(UInt32(10)))
        let secondNumber = Int(arc4random_uniform(UInt32(10)))
        
        let rand = CCRANDOM_0_1()
        var firstOperation: Operation!
        if rand < 0.30 {
            firstOperation = .Multiply
            targetNumber = firstNumber * secondNumber
        }
        else if rand < 0.65 {
            firstOperation = .Add
            targetNumber = firstNumber + secondNumber
        }
        else {
            firstOperation = .Subtract
            targetNumber = firstNumber - secondNumber
        }
        
        let thirdNumber = Int(arc4random_uniform(UInt32(10)))
        let rand2 = CCRANDOM_0_1()
        var secondOperation: Operation!
        if rand2 < 0.30 {
            secondOperation = .Multiply
            targetNumber = targetNumber * thirdNumber
        }
        else if rand2 < 0.65 {
            secondOperation = .Add
            targetNumber = targetNumber + thirdNumber
        }
        else {
            secondOperation = .Subtract
            targetNumber = targetNumber - thirdNumber
        }
        
        let fourthNumber = Int(arc4random_uniform(UInt32(10)))
        let rand3 = CCRANDOM_0_1()
        var thirdOperation: Operation!
        if rand3 < 0.30 {
            thirdOperation = .Multiply
            targetNumber = targetNumber * fourthNumber
        }
        else if rand3 < 0.65 {
            thirdOperation = .Add
            targetNumber = targetNumber + fourthNumber
        }
        else {
            thirdOperation = .Subtract
            targetNumber = targetNumber - fourthNumber
        }
        
        let fifthNumber = Int(arc4random_uniform(UInt32(10)))
        let rand4 = CCRANDOM_0_1()
        var fourthOperation: Operation!
        if rand4 < 0.30 {
            fourthOperation = .Multiply
            targetNumber = targetNumber * fifthNumber
        }
        else if rand4 < 0.65 {
            fourthOperation = .Add
            targetNumber = targetNumber + fifthNumber
        }
        else {
            fourthOperation = .Subtract
            targetNumber = targetNumber - fifthNumber
        }
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
    
    func solve(side: Side) {
        if side == .Bottom {
            
        }
        else {
            
        }
    }
}