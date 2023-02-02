//
//  Player.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public class Player: NSObject, NSSecureCoding, Codable, Identifiable {
    public var id = UUID()
    public var teamId = UUID()
    
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
    
    public var freeThrowAttempts: Int = 0
    public var freeThrowMade: Int = 0
    
    public var twoPointsAttempts: Int = 0
    public var twoPointsMade: Int = 0
    
    public var threePointsAttempts: Int = 0
    public var threePointsMade: Int = 0
    
//    public var freeThrowPercentage: Int?
//    public var twoPointsPercentage: Int?
//    public var threePointsPercentage: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teamId
        case firstName
        case lastName
        case number
        case points
        case rebOff
        case rebDef
        case assists
        case turnovers
        case interceptions
        case blocks
        case personalFoul
        case freeThrowAttempts
        case freeThrowMade
        case twoPointsAttempts
        case twoPointsMade
        case threePointsAttempts
        case threePointsMade
//        case freeThrowPercentage
//        case twoPointsPercentage
//        case threePointsPercentage
    }
    
    public init(id: UUID = UUID(), teamId: UUID, firstName: String, lastName: String, number: String, points: Int = 0, rebOff: Int = 0, rebDef: Int = 0, assists: Int = 0, turnovers: Int = 0, interceptions: Int = 0, blocks: Int = 0, personalFoul: Int = 0, freeThrowAttempts: Int = 0, freeThrowMade: Int = 0, twoPointsAttempts: Int = 0, twoPointsMade: Int = 0, threePointsAttempts: Int = 0, threePointsMade: Int = 0/*, freeThrowPercentage: Int? = nil, twoPointsPercentage: Int? = nil, threePointsPercentage: Int? = nil*/) {
        self.id = id
        self.teamId = teamId
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.points = points
        self.rebOff = rebOff
        self.rebDef = rebDef
        self.assists = assists
        self.turnovers = turnovers
        self.interceptions = interceptions
        self.blocks = blocks
        self.personalFoul = personalFoul
        self.freeThrowAttempts = freeThrowAttempts
        self.freeThrowMade = freeThrowMade
        self.twoPointsAttempts = twoPointsAttempts
        self.twoPointsMade = twoPointsMade
        self.threePointsAttempts = threePointsAttempts
        self.threePointsMade = threePointsMade
//        self.freeThrowPercentage = freeThrowPercentage
//        self.twoPointsPercentage = twoPointsPercentage
//        self.threePointsPercentage = threePointsPercentage
    }
    
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(number, forKey: "number")
        coder.encode(points, forKey: "points")
        coder.encode(rebOff, forKey: "rebOff")
        coder.encode(rebDef, forKey: "rebDef")
        coder.encode(assists, forKey: "assists")
        coder.encode(turnovers, forKey: "turnovers")
        coder.encode(interceptions, forKey: "interceptions")
        coder.encode(blocks, forKey: "blocks")
        coder.encode(personalFoul, forKey: "personalFoul")
        coder.encode(freeThrowAttempts, forKey: "freeThrowAttempts")
        coder.encode(freeThrowMade, forKey: "freeThrowMade")
        coder.encode(twoPointsAttempts, forKey: "twoPointsAttempts")
        coder.encode(twoPointsMade, forKey: "twoPointsMade")
        coder.encode(threePointsAttempts, forKey: "threePointsAttempts")
        coder.encode(threePointsMade, forKey: "threePointsMade")
//        coder.encode(freeThrowPercentage, forKey: "freeThrowPercentage")
//        coder.encode(twoPointsPercentage, forKey: "twoPointsPercentage")
//        coder.encode(threePointsPercentage, forKey: "threePointsPercentage")
    }
    
    public required init?(coder: NSCoder) {
        self.id = coder.decodeObject(of: NSUUID.self, forKey: "id") as UUID? ?? UUID()
        self.teamId = coder.decodeObject(of: NSUUID.self, forKey: "teamId") as UUID? ?? UUID()
        self.firstName = coder.decodeObject(of: NSString.self, forKey: "firstName") as String? ?? ""
        self.lastName = coder.decodeObject(of: NSString.self, forKey: "lastName") as String? ?? ""
        self.number = coder.decodeObject(of: NSString.self, forKey: "number") as String? ?? ""
        self.points = Int(coder.decodeInt64(forKey: "points"))
        self.rebOff = Int(coder.decodeInt64(forKey: "rebOff"))
        self.rebDef = Int(coder.decodeInt64(forKey: "rebDef"))
        self.assists = Int(coder.decodeInt64(forKey: "assists"))
        self.turnovers = Int(coder.decodeInt64(forKey: "turnovers"))
        self.interceptions = Int(coder.decodeInt64(forKey: "interceptions"))
        self.blocks = Int(coder.decodeInt64(forKey: "blocks"))
        self.personalFoul = Int(coder.decodeInt64(forKey: "personalFoul"))
        self.freeThrowAttempts = Int(coder.decodeInt64(forKey: "freeThrowAttempts"))
        self.freeThrowMade = Int(coder.decodeInt64(forKey: "freeThrowMade"))
        self.twoPointsAttempts = Int(coder.decodeInt64(forKey: "twoPointsAttempts"))
        self.twoPointsMade = Int(coder.decodeInt64(forKey: "twoPointsMade"))
        self.threePointsAttempts = Int(coder.decodeInt64(forKey: "threePointsAttempts"))
        self.threePointsMade = Int(coder.decodeInt64(forKey: "threePointsMade"))
//        self.freeThrowPercentage = Int(coder.decodeInt64(forKey: "freeThrowPercentage"))
//        self.twoPointsPercentage = Int(coder.decodeInt64(forKey: "twoPointsPercentage"))
//        self.threePointsPercentage = Int(coder.decodeInt64(forKey: "threePointsPercentage"))
    }
    
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(firstName, forKey: .firstName)
//        try container.encode(lastName, forKey: .lastName)
//        try container.encode(number, forKey: .number)
//        try container.encode(points, forKey: .points)
//        try container.encode(rebOff, forKey: .rebOff)
//        try container.encode(rebDef, forKey: .rebDef)
//        try container.encode(assists, forKey: .assists)
//        try container.encode(turnovers, forKey: .turnovers)
//        try container.encode(interceptions, forKey: .interceptions)
//        try container.encode(blocks, forKey: .blocks)
//        try container.encode(personalFoul, forKey: .personalFoul)
//        try container.encode(freeThrowAttempts, forKey: .freeThrowAttempts)
//        try container.encode(freeThrowMade, forKey: .freeThrowMade)
//        try container.encode(twoPointAttempts, forKey: .twoPointAttempts)
//        try container.encode(twoPointMade, forKey: .twoPointMade)
//        try container.encode(threePointAttempts, forKey: .threePointAttempts)
//        try container.encode(threePointMade, forKey: .threePointMade)
//        try container.encode(freeThrowPercentage, forKey: .freeThrowPercentage)
//        try container.encode(twoPointPercentage, forKey: .twoPointPercentage)
//        try container.encode(threePointPercentage, forKey: .threePointPercentage)
//    }
}

//extension Player: Equatable {
//    public static func == (lhs: Player, rhs: Player) -> Bool {
//        lhs.id == rhs.id
//    }
//}
