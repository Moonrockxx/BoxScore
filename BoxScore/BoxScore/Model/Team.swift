//
//  Team.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public class Team: Codable, Identifiable {
    public enum Categories: String, CaseIterable, Codable {
        case u11 = "U11"
        case u13 = "U13"
        case u15 = "U15"
        case u17 = "U17"
        case u20 = "U20"
        case s = "Senior"
    }
    
    //MARK: Informations
    public var id = UUID()
    public var clubName: String = ""
    public var categorie: Categories
    public var name: String
    public var players: [Player]?
    public var games: [Game]?
    public var teamNumber: String? = ""
    
    //MARK: Stats
    public var score: Int = 0
    public var rebOff: Int = 0
    public var rebDef: Int = 0
    public var interceptions: Int = 0
    public var assists: Int = 0
    public var blocks: Int = 0
    public var turnovers: Int = 0
    public var fouls: Int = 0
    
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
    
    public var isMenTeam: Bool
    public var isMultipleTeams: Bool
    
    public init(id: UUID = UUID(),
                clubName: String = "",
                categorie: Team.Categories,
                name: String,
                players: [Player]? = nil,
                games: [Game]? = nil,
                teamNumber: String? = "",
                score: Int = 0,
                rebOff: Int = 0,
                rebDef: Int = 0,
                interceptions: Int = 0,
                assists: Int = 0,
                blocks: Int = 0,
                turnovers: Int = 0,
                fouls: Int = 0,
                freeThrowAttempts: Double = 0,
                freeThrowMade: Double = 0,
                twoPointAttempts: Double = 0,
                twoPointMade: Double = 0,
                threePointAttempts: Double = 0,
                threePointMade: Double = 0,
                freeThrowPercentage: Double? = nil,
                twoPointPercentage: Double? = nil,
                threePointPercentage: Double? = nil,
                isMenTeam: Bool,
                isMultipleTeams: Bool) {
        self.id = id
        self.clubName = clubName
        self.categorie = categorie
        self.name = name
        self.players = players
        self.games = games
        self.teamNumber = teamNumber
        self.score = score
        self.rebOff = rebOff
        self.rebDef = rebDef
        self.interceptions = interceptions
        self.assists = assists
        self.blocks = blocks
        self.turnovers = turnovers
        self.fouls = fouls
        self.freeThrowAttempts = freeThrowAttempts
        self.freeThrowMade = freeThrowMade
        self.twoPointAttempts = twoPointAttempts
        self.twoPointMade = twoPointMade
        self.threePointAttempts = threePointAttempts
        self.threePointMade = threePointMade
        self.freeThrowPercentage = freeThrowPercentage
        self.twoPointPercentage = twoPointPercentage
        self.threePointPercentage = threePointPercentage
        self.isMenTeam = isMenTeam
        self.isMultipleTeams = isMultipleTeams
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case clubName
        case categorie
        case name
        case players
        case games
        case teamNumber
        case score
        case rebOff
        case rebDef
        case interceptions
        case assists
        case blocks
        case turnovers
        case fouls
        case freeThrowAttempts
        case freeThrowMade
        case twoPointAttempts
        case twoPointMade
        case threePointAttempts
        case threePointMade
        case freeThrowPercentage
        case twoPointPercentage
        case threePointPercentage
        case isMenTeam
        case isMultipleTeams
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        clubName = try values.decode(String.self, forKey: .clubName)
        categorie = try values.decode(Team.Categories.self, forKey: .categorie)
        name = try values.decode(String.self, forKey: .name)
        players = try values.decode([Player].self, forKey: .players)
        games = try values.decode([Game].self, forKey: .games)
        teamNumber = try values.decode(String.self, forKey: .teamNumber)
        score = try values.decode(Int.self, forKey: .score)
        rebOff = try values.decode(Int.self, forKey: .rebOff)
        rebDef = try values.decode(Int.self, forKey: .rebDef)
        interceptions = try values.decode(Int.self, forKey: .interceptions)
        assists = try values.decode(Int.self, forKey: .assists)
        blocks = try values.decode(Int.self, forKey: .blocks)
        turnovers = try values.decode(Int.self, forKey: .turnovers)
        fouls = try values.decode(Int.self, forKey: .fouls)
        freeThrowAttempts = try values.decode(Double.self, forKey: .freeThrowAttempts)
        freeThrowMade = try values.decode(Double.self, forKey: .freeThrowMade)
        twoPointAttempts = try values.decode(Double.self, forKey: .twoPointAttempts)
        twoPointMade = try values.decode(Double.self, forKey: .twoPointMade)
        threePointAttempts = try values.decode(Double.self, forKey: .threePointAttempts)
        threePointMade = try values.decode(Double.self, forKey: .threePointMade)
        freeThrowPercentage = try values.decode(Double.self, forKey: .freeThrowPercentage)
        twoPointPercentage = try values.decode(Double.self, forKey: .twoPointPercentage)
        threePointPercentage = try values.decode(Double.self, forKey: .threePointPercentage)
        isMenTeam = try values.decode(Bool.self, forKey: .isMenTeam)
        isMultipleTeams = try values.decode(Bool.self, forKey: .isMultipleTeams)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(clubName, forKey: .clubName)
        try container.encode(categorie.rawValue, forKey: .categorie)
        try container.encode(players, forKey: .players)
        try container.encode(games, forKey: .games)
        try container.encode(teamNumber, forKey: .teamNumber)
        try container.encode(score, forKey: .score)
        try container.encode(rebOff, forKey: .rebOff)
        try container.encode(rebDef, forKey: .rebDef)
        try container.encode(interceptions, forKey: .interceptions)
        try container.encode(assists, forKey: .assists)
        try container.encode(blocks, forKey: .blocks)
        try container.encode(turnovers, forKey: .turnovers)
        try container.encode(fouls, forKey: .fouls)
        try container.encode(freeThrowAttempts, forKey: .freeThrowAttempts)
        try container.encode(freeThrowMade, forKey: .freeThrowMade)
        try container.encode(twoPointAttempts, forKey: .twoPointAttempts)
        try container.encode(twoPointMade, forKey: .twoPointMade)
        try container.encode(threePointAttempts, forKey: .threePointAttempts)
        try container.encode(threePointMade, forKey: .threePointMade)
        try container.encode(freeThrowPercentage, forKey: .freeThrowPercentage)
        try container.encode(twoPointPercentage, forKey: .twoPointPercentage)
        try container.encode(threePointPercentage, forKey: .threePointPercentage)
        try container.encode(isMenTeam, forKey: .isMenTeam)
        try container.encode(isMultipleTeams, forKey: .isMultipleTeams)
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
