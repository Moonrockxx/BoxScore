//
//  Game.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Game {
    public var id = UUID()
    
    public var homeTeam: Team?
    public var awayTeam: Team?
}

