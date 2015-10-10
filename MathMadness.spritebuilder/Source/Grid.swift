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
    weak var c1, c2, c3: CCNode!
    
    var tiles: [Tile] = []
    var numbers: Int = 0
    var operators: Int = 0
    var side: Side = .Top
    
    var delegate: GridDelegate?
    
    func spawnNewTiles() {
        for index in 0..<12 {
            
            let newTile: Tile = CCBReader.load("Tile") as! Tile
            
            tiles.append(newTile)
            newTile.position = ccp(0, 0)
            
            newTile.delegate = self
            
            if newTile.randomize(side, currentNumbers: numbers, currentOperators: operators) {
                operators++
            }
            else {
                numbers++
            }
            
            switch index {
            case 0:
                a1.addChild(newTile)
            case 1:
                a2.addChild(newTile)
            case 2:
                a3.addChild(newTile)
            case 3:
                a4.addChild(newTile)
            case 4:
                b1.addChild(newTile)
            case 5:
                b2.addChild(newTile)
            case 6:
                b3.addChild(newTile)
            case 7:
                b4.addChild(newTile)
            case 8:
                c2.addChild(newTile)
            case 9:
                c3.addChild(newTile)
            default:
                print("test")
            }
        }
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
}

extension Grid: TileDelegate {
    
    func tileWasPressed(value: Values, side: Side, tile: Tile) {
        delegate?.tilePressed(value, side: side, tile: tile)
    }
}

protocol GridDelegate {
    func tilePressed(value: Values, side: Side, tile: Tile)
    func clear(side: Side)
    func solve(side: Side)
}