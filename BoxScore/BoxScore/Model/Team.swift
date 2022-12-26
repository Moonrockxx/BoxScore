//
//  Team.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Team: Identifiable {
    
    public enum Categories: String, CaseIterable {
        case u11 = "U11"
        case u13 = "U13"
        case u15 = "U15"
        case u17 = "U17"
        case u20 = "U20"
        case s = "Senior"
    }
    
    public var id = UUID()
    
    public var categorie: Categories
    public var score: Int
    public var players: [Player]?
    public var games: [Game]?
    public var teamNumber: String? = ""
    
    public var isMenTeam: Bool
    public var isMultipleTeams: Bool
    
    public var clubName: String = ""
    public var name: String {
        return "\(categorie.rawValue) - \(isMenTeam ? "M" : "F") \(isMultipleTeams ? teamNumber ?? "" : "")"
    }
    
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
