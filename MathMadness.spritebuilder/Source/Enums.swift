//
//  Enums.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 10/11/15.
//  Copyright © 2015 Zachary Espiritu. All rights reserved.
//

import Foundation

enum Values: Int {
    case zero = 0
    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case add = -1
    case subtract = -2
    case multiply = -3
}

enum Side: String {
    case Top = "Top"
    case Bottom = "Bottom"
}

enum Operation: String {
    case Add = " + "
    case Subtract = " – "
    case Multiply = " × "
}