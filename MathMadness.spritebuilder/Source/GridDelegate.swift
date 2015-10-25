//
//  GridDelegate.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/11/15.
//  Copyright © 2015 Zachary Espiritu. All rights reserved.
//

import Foundation

protocol GridDelegate {
    func tilePressed(string: String, side: Side, tile: Tile) // Called whenever a tile is pressed.
    func clear(side: Side) // Called whenever the clear button is pressed.
    func solve(side: Side) // Called whenever the solve button is pressed.
    func saveStringEquationSolution(stringToSave: String, side: Side) // Called whenever a new puzzle is generated. Returns the String form of one possible solution to the puzzle to display when a player loses and the solution of the losing player's current equation should be displayed.
}