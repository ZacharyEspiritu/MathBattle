//
//  Tile.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

enum Values: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case eleven = "11"
    case twelve = "12"
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
}
enum Side: String {
    case Top = "Top"
    case Bottom = "Bottom"
}

class Tile: CCNode {
    
    weak var label: CCLabelTTF!
    weak var button: CCButton!
    
    var value: Values = .one
    var side: Side = .Top
    
    var delegate: TileDelegate?
    
    func randomize(side: Side, currentNumbers: Int, currentOperators: Int) -> Bool {
        let rand = CCRANDOM_0_1()
        self.side = side
        
        if currentOperators < 3 {
            if rand < 0.25 {
                value = .add
                label.string = "+"
            }
            else if rand < 0.5 {
                value = .subtract
                label.string = "-"
            }
            else if rand < 0.75 {
                value = .multiply
                label.string = "×"
            }
            else {
                value = .divide
                label.string = "÷"
            }
            
            return true
        }
        else {
            if rand < 1/12 {
                value = .one
                label.string = "1"
            }
            else if rand < 2/12 {
                value = .two
                label.string = "2"
            }
            else if rand < 3/12 {
                value = .three
                label.string = "3"
            }
            else if rand < 4/12 {
                value = .four
                label.string = "4"
            }
            else if rand < 5/12 {
                value = .five
                label.string = "5"
            }
            else if rand < 6/12 {
                value = .six
                label.string = "6"
            }
            else if rand < 7/12 {
                value = .seven
                label.string = "7"
            }
            else if rand < 8/12 {
                value = .eight
                label.string = "8"
            }
            else if rand < 9/12 {
                value = .nine
                label.string = "9"
            }
            else if rand < 10/12 {
                value = .ten
                label.string = "10"
            }
            else if rand < 11/12 {
                value = .eleven
                label.string = "11"
            }
            else {
                value = .twelve
                label.string = "12"
            }
            return false
        }
    }
    
    func pressed() {
        delegate?.tileWasPressed(value, side: side, tile: self)
        print(label.string)
        print(side.rawValue)
        
        self.button.enabled = false
        self.cascadeColorEnabled = true
        self.color = CCColor(red: 52/255, green: 52/255, blue: 52/255)
    }
    
}

protocol TileDelegate {
    
    func tileWasPressed(value: Values, side: Side, tile: Tile)
    
}