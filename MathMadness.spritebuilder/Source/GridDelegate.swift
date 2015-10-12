//
//  GridDelegate.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/11/15.
//  Copyright © 2015 Zachary Espiritu. All rights reserved.
//

import Foundation

protocol GridDelegate {
    func tilePressed(string: String, side: Side, tile: Tile)
    func clear(side: Side)
    func solve(side: Side)
    func saveStringEquationSolution(stringToSave: String, side: Side)
}