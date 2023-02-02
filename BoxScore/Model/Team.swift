//
//  Team.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public class Team: NSObject, NSSecureCoding, Codable, Identifiable {
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
    public var categorie: Categories?
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
    
    public var freeThrowAttempts: Int = 0
    public var freeThrowMade: Int = 0
    
    public var twoPointsAttempts: Int = 0
    public var twoPointsMade: Int = 0
    
    public var threePointsAttempts: Int = 0
    public var threePointsMade: Int = 0
    
    public var isMenTeam: Bool
    public var isMultipleTeams: Bool
    
    public init(id: UUID = UUID(),
                clubName: String = "",
                categorie: Team.Categories,
                name: String,
                players: [Player]?,
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
                freeThrowAttempts: Int = 0,
                freeThrowMade: Int = 0,
                twoPointsAttempts: Int = 0,
                twoPointsMade: Int = 0,
                threePointsAttempts: Int = 0,
                threePointsMade: Int = 0,
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
        self.twoPointsAttempts = twoPointsAttempts
        self.twoPointsMade = twoPointsMade
        self.threePointsAttempts = threePointsAttempts
        self.threePointsMade = threePointsMade
        self.isMenTeam = isMenTeam
        self.isMultipleTeams = isMultipleTeams
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case clubName
        case categorie
        case name
        case players
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
        case twoPointsAttempts
        case twoPointsMade
        case threePointsAttempts
        case threePointsMade
        case isMenTeam
        case isMultipleTeams
    }
    
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(clubName, forKey: "clubName")
        coder.encode(categorie?.rawValue, forKey: "categorie")
        coder.encode(name, forKey: "name")
        coder.encode(players, forKey: "players")
        coder.encode(teamNumber, forKey: "teamNumber")
        coder.encode(score, forKey: "score")
        coder.encode(rebOff, forKey: "rebOff")
        coder.encode(rebDef, forKey: "rebDef")
        coder.encode(interceptions, forKey: "interceptions")
        coder.encode(assists, forKey: "assists")
        coder.encode(blocks, forKey: "blocks")
        coder.encode(turnovers, forKey: "turnovers")
        coder.encode(fouls, forKey: "fouls")
        coder.encode(freeThrowAttempts, forKey: "freeThrowAttempts")
        coder.encode(freeThrowMade, forKey: "freeThrowMade")
        coder.encode(twoPointsAttempts, forKey: "twoPointsAttempts")
        coder.encode(twoPointsMade, forKey: "twoPointsMade")
        coder.encode(threePointsAttempts, forKey: "threePointsAttempts")
        coder.encode(threePointsMade, forKey: "threePointsMade")
        coder.encode(isMenTeam, forKey: "isMenTeam")
        coder.encode(isMultipleTeams, forKey: "isMultipleTeam")
    }
    
    public required init?(coder: NSCoder) {
        id = coder.decodeObject(of: NSUUID.self, forKey: "id") as UUID? ?? UUID()
        clubName = coder.decodeObject(of: NSString.self, forKey: "clubName") as String? ?? ""
        categorie = Team.Categories(rawValue: (coder.decodeObject(forKey: "categorie") as? String ?? ""))
        name = coder.decodeObject(of: NSString.self, forKey: "name") as String? ?? ""
        players = coder.decodeArrayOfObjects(ofClass: Player.self, forKey: "players")
        teamNumber = coder.decodeObject(of: NSString.self, forKey: "teamNumber") as String? ?? ""
        score = Int(coder.decodeInt64(forKey: "score"))
        rebOff = Int(coder.decodeInt64(forKey: "rebOff"))
        rebDef = Int(coder.decodeInt64(forKey: "rebDef"))
        interceptions = Int(coder.decodeInt64(forKey: "interceptions"))
        assists = Int(coder.decodeInt64(forKey: "assists"))
        blocks = Int(coder.decodeInt64(forKey: "blocks"))
        turnovers = Int(coder.decodeInt64(forKey: "turnovers"))
        fouls = Int(coder.decodeInt64(forKey: "fouls"))
        freeThrowAttempts = Int(coder.decodeInt64(forKey: "freeThrowAttempts"))
        freeThrowMade = Int(coder.decodeInt64(forKey: "freeThrowMade"))
        twoPointsAttempts = Int(coder.decodeInt64(forKey: "twoPointsAttempts"))
        twoPointsMade = Int(coder.decodeInt64(forKey: "twoPointsMade"))
        threePointsAttempts = Int(coder.decodeInt64(forKey: "threePointsAttempts"))
        threePointsMade = Int(coder.decodeInt64(forKey: "threePointsMade"))
        isMenTeam = coder.decodeBool(forKey: "isMenTeam")
        isMultipleTeams = coder.decodeBool(forKey: "isMultipleTeams")
    }
}

@objc(TeamTransformer)
class TeamTransformer: NSSecureUnarchiveFromDataTransformer {
    
    static let name = NSValueTransformerName(rawValue: String(describing: TeamTransformer.self))
    
    override static var allowedTopLevelClasses: [AnyClass] {
        return [Team.self, NSString.self]
    }
    
    /// Registers the transformer.
    public static func register() {
        let transformer = TeamTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
    
}
