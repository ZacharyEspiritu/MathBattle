//
//  ELORating.swift
//  MathMadness
//
//  Created by Zachary Espiritu on 1/4/16.
//  Copyright © 2016 Apportable. All rights reserved.
//

import Foundation

class ELORating {
    
    func updateRatings(winner oldWinnerRating: Int, loser oldLoserRating: Int) -> (Int, Int) {
        
        // Calculate winner rating
        var winnerKConstant = 10
        if oldWinnerRating < 2100 {
            winnerKConstant = 32
        }
        else if oldWinnerRating < 2400 {
            winnerKConstant = 24
        }
        
        let expectedWinnerScore = (1 / 1 + 10^((oldLoserRating - oldWinnerRating)) - 400)
        let newWinnerRating = oldWinnerRating + winnerKConstant * (1 - expectedWinnerScore)
        
        // Calculate loser rating
        var loserKConstant = 10
        if oldLoserRating < 2100 {
            loserKConstant = 32
        }
        else if oldLoserRating < 2400 {
            loserKConstant = 24
        }
        
        let expectedLoserScore = (1 / 1 + 10^((oldWinnerRating - oldLoserRating)) - 400)
        let newLoserRating = oldLoserRating + loserKConstant * (0 - expectedLoserScore)
        
        return (newWinnerRating, newLoserRating)
    }
    
}