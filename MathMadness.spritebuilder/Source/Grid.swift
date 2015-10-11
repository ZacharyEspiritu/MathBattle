//
//  Grid.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class Grid: CCNode {
    
    weak var a1, a2, a3, a4: CCNode!
    weak var b1, b2, b3, b4: CCNode!
    weak var c1, c2, c3, c4: CCNode!
    
    var tiles: [Tile] = []
    var numbers: Int = 0
    var operators: Int = 0
    var side: Side = .Top
    
    var difficulty: Int = 10
    
    weak var scoreLabel: CCLabelTTF!
    var puzzlesRemaining: Int = 5 {
        didSet {
            scoreLabel.string = "\(puzzlesRemaining)\nleft"
        }
    }
    
    var delegate: GridDelegate?
    
    func generateNewRound() -> Int {
        var targetNumber: Int = 0
        
        let firstNumber = Int(arc4random_uniform(UInt32(difficulty)))
        let secondNumber = Int(arc4random_uniform(UInt32(difficulty)))
        
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
        
        print("\(firstNumber)\(firstOperation.rawValue)\(secondNumber)\(secondOperation.rawValue)\(thirdNumber)\(thirdOperation.rawValue)\(fourthNumber)\(fourthOperation.rawValue)\(fifthNumber) = \(targetNumber)")
        delegate?.saveStringEquationSolution("(((\(firstNumber)\(firstOperation.rawValue)\(secondNumber))\(secondOperation.rawValue)\(thirdNumber))\(thirdOperation.rawValue)\(fourthNumber))\(fourthOperation.rawValue)\(fifthNumber) = \(targetNumber)", side: side)
        
        var array: [String] = []
        array.append("\(firstNumber)")
        array.append("\(firstOperation.rawValue)")
        array.append("\(secondNumber)")
        array.append("\(secondOperation.rawValue)")
        array.append("\(thirdNumber)")
        array.append("\(thirdOperation.rawValue)")
        array.append("\(fourthNumber)")
        array.append("\(fourthOperation.rawValue)")
        array.append("\(fifthNumber)")
        
        for index in 0..<9 {
            let newTile: Tile = CCBReader.load("Tile") as! Tile
            
            tiles.append(newTile)
            newTile.position = ccp(0, 0)
            
            newTile.delegate = self
            newTile.side = side
            
            let stringIndex = Int(arc4random_uniform(UInt32(array.count)))
            
            newTile.label.string = array[stringIndex]
            
            switch array[stringIndex] {
            case "0":
                newTile.value = .zero
            case "1":
                newTile.value = .one
            case "2":
                newTile.value = .two
            case "3":
                newTile.value = .three
            case "4":
                newTile.value = .four
            case "5":
                newTile.value = .five
            case "6":
                newTile.value = .six
            case "7":
                newTile.value = .seven
            case "8":
                newTile.value = .eight
            case "9":
                newTile.value = .nine
            case " + ":
                newTile.value = .add
            case " – ":
                newTile.value = .subtract
            case " × ":
                newTile.value = .multiply
            default:
                break
            }
            array.removeAtIndex(stringIndex)
            
            switch index {
            case 0:
                c4.addChild(newTile)
            case 1:
                a2.addChild(newTile)
            case 2:
                a3.addChild(newTile)
            case 3:
                a4.addChild(newTile)
            case 4:
                c3.addChild(newTile)
            case 5:
                b2.addChild(newTile)
            case 6:
                b3.addChild(newTile)
            case 7:
                b4.addChild(newTile)
            case 8:
                c2.addChild(newTile)
            default:
                print("test")
            }
            
            newTile.scale = 0
            newTile.runAction(CCActionScaleTo(duration: 0.25, scale: 1))
        }
        
        return targetNumber
    }
    
    func removeAllTiles() {
        for tile in tiles {
            tile.runAction(CCActionEaseSineIn(action: CCActionScaleTo(duration: 0.25, scale: 0)))
        }
        delay(0.3) {
            for index in 0..<9 {
                switch index {
                case 0:
                    self.c4.removeAllChildren()
                case 1:
                    self.a2.removeAllChildren()
                case 2:
                    self.a3.removeAllChildren()
                case 3:
                    self.a4.removeAllChildren()
                case 4:
                    self.c3.removeAllChildren()
                case 5:
                    self.b2.removeAllChildren()
                case 6:
                    self.b3.removeAllChildren()
                case 7:
                    self.b4.removeAllChildren()
                case 8:
                    self.c2.removeAllChildren()
                default:
                    print("test")
                }
            }
        }
    }
    
    func increaseScore() {
        puzzlesRemaining--
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func clear() {
        delegate?.clear(side)
        for tile in tiles {
            tile.button.enabled = true
            tile.color = CCColor(red: 255/255, green: 255/255, blue: 255/255)
        }
    }
    
    func solve() {
        delegate?.solve(side)
    }
    
    func breakTiles() {
        self.delay(0.07) {
            AudioServicesPlayAlertSound(UInt32(kSystemSoundID_Vibrate))
        }
        
        for tile in tiles {
            var random = Int(arc4random_uniform(9))
            let negativeRandom = Int(arc4random_uniform(2))
            
            random = random * 4
            
            if random == 0 {
                random = 30
            }
            
            if negativeRandom != 0 {
                random = -random
            }
            
            let tiltAction = CCActionEaseElasticOut(action: CCActionRotateBy(duration: 0.5, angle: Float(random)))
            
            tile.runAction(tiltAction)
        }
    }
}

extension Grid: TileDelegate {
    
    func tileWasPressed(string: String, side: Side, tile: Tile) {
        delegate?.tilePressed(string, side: side, tile: tile)
    }
}

protocol GridDelegate {
    func tilePressed(string: String, side: Side, tile: Tile)
    func clear(side: Side)
    func solve(side: Side)
    func saveStringEquationSolution(stringToSave: String, side: Side)
}