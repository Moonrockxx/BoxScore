//
//  Player.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Player: Identifiable {
    public var id = UUID()
    
    public var firstName: String
    public var lastName: String
    public var number: String
    
    public var points: Int = 0
    public var rebOff: Int = 0
    public var rebDef: Int = 0
    public var assists: Int = 0
    public var turnovers: Int = 0
    public var interceptions: Int = 0
    public var blocks: Int = 0
    public var personalFoul: Int = 0
    
    public var totalRebonds: Int? {
        return rebOff + rebDef
    }
    
    public var freeThrowAttempts: Double = 0
    public var freeThrowMade: Double = 0
    
    public var twoPointAttempts: Double = 0
    public var twoPointMade: Double = 0
    
    public var threePointAttempts: Double = 0
    public var threePointMade: Double = 0

    public var freeThrowPercentage: Double?
    public var twoPointPercentage: Double?
    public var threePointPercentage: Double?
}

extension Player: Equatable {
    
}
