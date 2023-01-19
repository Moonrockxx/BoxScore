//
//  Game.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public struct Game: Codable {
    public var id = UUID()
    
    public var yourTeam: Team?
    public var oppositeTeam: Team?
    
    public init(id: UUID = UUID(),
                yourTeam: Team? = nil,
                oppositeTeam: Team? = nil) {
        self.id = id
        self.yourTeam = yourTeam
        self.oppositeTeam = oppositeTeam
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case yourTeam
        case oppositeTeam
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(yourTeam, forKey: .yourTeam)
        try container.encode(oppositeTeam, forKey: .oppositeTeam)
    }
}

