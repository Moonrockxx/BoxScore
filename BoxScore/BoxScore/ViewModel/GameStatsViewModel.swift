//
//  GameStatsViewModel.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import Foundation
import SwiftUI

public enum RecordableStats: String {
    case freeThrow
    case twoPoints
    case threePoints
    case rebond
    case assist
    case interception
    case block
    case personalFoul
    case turnOver
    
    static let pointsRow: [RecordableStats] = [.freeThrow, .twoPoints, .threePoints]
    static let secondRow: [RecordableStats] = [.rebond, .interception, .block]
    static let thirdRow: [RecordableStats] = [.personalFoul, .turnOver]
    
    var title: String {
        switch self {
        case .freeThrow:
            return "1 pt"
        case .twoPoints:
            return "2 pts"
        case .threePoints:
            return "3 pts"
        case .rebond:
            return "Reb"
        case .assist:
            return "Ast"
        case .interception:
            return "Int"
        case .block:
            return "Blk"
        case .personalFoul:
            return "PF"
        case .turnOver:
            return "TO"
        }
    }
    
    //        var action: () -> () {
    //            switch self {
    //            case .freeThrow:
    //                <#code#>
    //            case .twoPoints:
    //                <#code#>
    //            case .threePoints:
    //                <#code#>
    //            case .rebond:
    //                <#code#>
    //            case .assist:
    //                <#code#>
    //            case .interception:
    //                <#code#>
    //            case .block:
    //                <#code#>
    //            case .personalFoul:
    //                <#code#>
    //            case .turnOver:
    //                <#code#>
    //            }
    //        }
}

public class GameStatsViewModel: ObservableObject {
    //MARK: Variables
    @Published public var selectedTeam: Team = Team(categorie: .s ,score: 0, isMenTeam: false, isMultipleTeams: false)
    @Published public var homeAwaySelection: Int = 0
    
    @Published public var yourTeam: Team?
    @Published public var addForTeam: Team?
    
    @Published public var oppositeTeam: Team?
    @Published public var oppositeTeamName: String = ""
    
    @Published public var showAddStatsSheet: Bool = false
    @Published public var isShotMade: Bool = true
    @Published public var isDefensiveRebond: Bool = false
    
    @Published public var sheetType: RecordableStats = .freeThrow
    
    @Published public var game: Game?
    
    public var clubName: String = ""
    
    //MARK: Constants
    public let pointsRow: [RecordableStats] = [.freeThrow, .twoPoints, .threePoints]
    public let secondRow: [RecordableStats] = [.rebond, .interception, .block]
    public let thirdRow: [RecordableStats] = [.personalFoul, .turnOver]
    
    //MARK: Computed properties
    public var shouldDisplayToogle: Bool {
        sheetType == .freeThrow
        || sheetType == .twoPoints
        || sheetType == .threePoints
        || sheetType == .rebond
    }
    
    public var shouldGoNext: Bool {
        !oppositeTeamName.isEmpty
        && oppositeTeamName != ""
    }
    
    public var isHomeGame: Bool {
        return homeAwaySelection == 0
    }
    
    public var activePlayers: [Player] = []
    
    init() {
        self.clubName = UserDefaults.standard.object(forKey: "clubName") as? String ?? "Your club"
    }
    
    //MARK: Functions
    public func startNewGame() {
        self.yourTeam = Team(categorie: selectedTeam.categorie,
                             score: 0,
                             players: activePlayers,
                             games: nil,
                             teamNumber: nil,
                             isMenTeam: selectedTeam.isMenTeam,
                             isMultipleTeams: false,
                             clubName: clubName)
        
        self.oppositeTeam = Team(categorie: selectedTeam.categorie,
                                 score: 0,
                                 players: nil,
                                 games: nil,
                                 teamNumber: nil,
                                 isMenTeam: selectedTeam.isMenTeam,
                                 isMultipleTeams: false,
                                 clubName: oppositeTeamName)
        
        self.game = Game(homeTeam: isHomeGame ? yourTeam : oppositeTeam,
                         awayTeam: isHomeGame ? oppositeTeam : yourTeam)
    }
    
//    public func addStat(type: RecordableStats) {
//        switch type {
//        case .freeThrow:
//            if addForTeam?.players?.isEmpty {
//                game?.homeTeam.
//            } else {
//
//            }
//
//        case .twoPoints:
//
//
//        case .threePoints:
//
//
//        default:
//            break
//        }
//    }
    
}
