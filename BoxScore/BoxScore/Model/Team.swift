//
//  Team.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Team: Identifiable {
    
    public var id: String
    
    public var name: String
    public var score: Int
    public var players: [Player]?
    public var games: [Game]?
    
    public var isMenTeam: Bool
    
    public var imageForRow: String {
        if isMenTeam {
            return "menTeam"
        } else {
            return "girlTeam"
        }
    }
    
    public var offsetForImageRow: Double {
        if isMenTeam {
            return 40
        } else {
            return 0
        }
    }
}

extension Team: Hashable {
    public static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
