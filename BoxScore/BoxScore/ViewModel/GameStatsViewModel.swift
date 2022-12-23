//
//  GameStatsViewModel.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import Foundation

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
    @Published public var selectedTeam: Team = Team(categorie: .s ,score: 0, isMenTeam: false, isMultipleTeams: false)
    @Published public var homeAwaySelection: Int = 0
    @Published public var oppositeTeamName: String = ""
    
    @Published public var yourTeam: Team?
    @Published public var oppositeTeam: Team?
    
    @Published public var game: Game?
    
    public let pointsRow: [RecordableStats] = [.freeThrow, .twoPoints, .threePoints]
    public let secondRow: [RecordableStats] = [.rebond, .interception, .block]
    public let thirdRow: [RecordableStats] = [.personalFoul, .turnOver]
    
    public var shouldGoNext: Bool {
        return selectedTeam.name != ""
        && !oppositeTeamName.isEmpty
        && oppositeTeamName != ""
    }
    
    private var isHomeGame: Bool {
        return homeAwaySelection == 0
    }
    
    public var activePlayers: [Player] = []
    
    //    public func startNewGame() {
    //        self.yourTeam = Team(score: 0, players: activePlayers, games: nil, isMenTeam: selectedTeam.isMenTeam, categorie: , isFirstTeam: true)
    //        self.oppositeTeam = Team(name: oppositeTeamName, score: 0, isMenTeam: selectedTeam.isMenTeam)
    //        self.game = Game(homeTeam: isHomeGame ? yourTeam : oppositeTeam,
    //                         awayTeam: isHomeGame ? oppositeTeam : yourTeam)
    //    }
    
    public func addPoints(type: RecordableStats, for player: Player) {
        //        switch type {
        //        case .freeThrow:
        //            player.freeThrowMade += 1
        //            player.points += 1
        //
        //        case .twoPoints:
        //            player.twoPointMade += 1
        //            player.points += 2
        //
        //        case .threePoints:
        //            player.threePointMade += 1
        //            player.points += 3
        //
        //        default:
        //            break
        //        }
    }
    
}