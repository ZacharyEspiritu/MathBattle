//
//  TileDelegate.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/11/15.
//  Copyright © 2015 Zachary Espiritu. All rights reserved.
//

import Foundation

protocol TileDelegate {
    func tileWasPressed(string: String, side: Side, tile: Tile)
}