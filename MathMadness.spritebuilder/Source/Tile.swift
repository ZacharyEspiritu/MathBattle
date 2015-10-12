//
//  Tile.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/10/15.
//  Copyright © 2015 Zachary Espiritu. All rights reserved.
//

import Foundation

class Tile: CCNode {
    
    // MARK: Variables
    
    weak var label: CCLabelTTF!
    weak var button: CCButton!
    
    var value: Values = .one
    var side: Side = .Top
    
    var delegate: TileDelegate?
    
    
    // MARK: Functions
    
    func pressed() {
        delegate?.tileWasPressed(label.string, side: side, tile: self)
        print(label.string)
        print(side.rawValue)
        
        self.button.enabled = false
        self.cascadeColorEnabled = true
        self.color = CCColor(red: 52/255, green: 52/255, blue: 52/255)
    }
}