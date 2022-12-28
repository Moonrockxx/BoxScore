//
//  Game.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Game {
    public var id = UUID()
    
    public var yourTeam: Team?
    public var oppositeTeam: Team?
}

