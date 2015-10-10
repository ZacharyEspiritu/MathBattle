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
    weak var topGrid: Grid!
    
    weak var world: CCNode!
    
    func didLoadFromCCB() {
        self.userInteractionEnabled = true
        self.multipleTouchEnabled = true
        
        bottomGrid.side = .Bottom
        topGrid.side = .Top
        
        bottomGrid.spawnNewTiles()
        topGrid.spawnNewTiles()
        
        print(bottomGrid.side.rawValue)
    }
}