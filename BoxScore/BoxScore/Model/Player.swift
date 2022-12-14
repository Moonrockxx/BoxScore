//
//  Player.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Player: Identifiable {
    public var id: String
    
    public var firstName: String
    public var lastName: String
    public var number: String
    
    public var points: Int?
    public var rebonds: Int?
    public var assists: Int?
    public var turnovers: Int?
    public var interceptions: Int?
    public var blocks: Int?
    
    public var freeThrowAttempts: Double?
    public var freeThrowMade: Double?
    
    public var twoPointAttempts: Double?
    public var twoPointMade: Double?
    
    public var threePointAttempts: Double?
    public var threePointMade: Double?

    public var freeThrowPercentage: Double?
    public var twoPointPercentage: Double?
    public var threePointPercentage: Double?
}
