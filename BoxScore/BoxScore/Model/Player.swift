//
//  Player.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public class Player: Codable, Identifiable {
    
    
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
    
    public var freeThrowAttempts: Double = 0
    public var freeThrowMade: Double = 0
    
    public var twoPointAttempts: Double = 0
    public var twoPointMade: Double = 0
    
    public var threePointAttempts: Double = 0
    public var threePointMade: Double = 0

    public var freeThrowPercentage: Double?
    public var twoPointPercentage: Double?
    public var threePointPercentage: Double?
    
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
        case twoPointAttempts
        case twoPointMade
        case threePointAttempts
        case threePointMade
        case freeThrowPercentage
        case twoPointPercentage
        case threePointPercentage
    }
    
    public init(id: UUID = UUID(), teamId: UUID, firstName: String, lastName: String, number: String, points: Int = 0, rebOff: Int = 0, rebDef: Int = 0, assists: Int = 0, turnovers: Int = 0, interceptions: Int = 0, blocks: Int = 0, personalFoul: Int = 0, freeThrowAttempts: Double = 0, freeThrowMade: Double = 0, twoPointAttempts: Double = 0, twoPointMade: Double = 0, threePointAttempts: Double = 0, threePointMade: Double = 0, freeThrowPercentage: Double? = nil, twoPointPercentage: Double? = nil, threePointPercentage: Double? = nil) {
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
        self.twoPointAttempts = twoPointAttempts
        self.twoPointMade = twoPointMade
        self.threePointAttempts = threePointAttempts
        self.threePointMade = threePointMade
        self.freeThrowPercentage = freeThrowPercentage
        self.twoPointPercentage = twoPointPercentage
        self.threePointPercentage = threePointPercentage
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(firstName, forKey: .firstName)
        try container.encode(lastName, forKey: .lastName)
        try container.encode(number, forKey: .number)
        try container.encode(points, forKey: .points)
        try container.encode(rebOff, forKey: .rebOff)
        try container.encode(rebDef, forKey: .rebDef)
        try container.encode(assists, forKey: .assists)
        try container.encode(turnovers, forKey: .turnovers)
        try container.encode(interceptions, forKey: .interceptions)
        try container.encode(blocks, forKey: .blocks)
        try container.encode(personalFoul, forKey: .personalFoul)
        try container.encode(freeThrowAttempts, forKey: .freeThrowAttempts)
        try container.encode(freeThrowMade, forKey: .freeThrowMade)
        try container.encode(twoPointAttempts, forKey: .twoPointAttempts)
        try container.encode(twoPointMade, forKey: .twoPointMade)
        try container.encode(threePointAttempts, forKey: .threePointAttempts)
        try container.encode(threePointMade, forKey: .threePointMade)
        try container.encode(freeThrowPercentage, forKey: .freeThrowPercentage)
        try container.encode(twoPointPercentage, forKey: .twoPointPercentage)
        try container.encode(threePointPercentage, forKey: .threePointPercentage)
    }
}

extension Player: Equatable {
    public static func == (lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
}
