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
    @Published public var shouldDisplayAssistPicker: Bool = false
    @Published public var shouldHighlightYourTeamButton: Bool = false
    @Published public var shouldHighlightOppositeTeamButton: Bool = false
    
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
        self.yourTeam = Team(clubName: clubName,
                             categorie: selectedTeam.categorie,
                             players: activePlayers,
                             games: nil,
                             teamNumber: nil,
                             score: 0,
                             isMenTeam: selectedTeam.isMenTeam,
                             isMultipleTeams: false)
        
        self.oppositeTeam = Team(clubName: oppositeTeamName,
                                 categorie: selectedTeam.categorie,
                                 players: nil,
                                 games: nil,
                                 teamNumber: nil,
                                 score: 0,
                                 isMenTeam: selectedTeam.isMenTeam,
                                 isMultipleTeams: false)
        
        self.game = Game(yourTeam: yourTeam,
                         oppositeTeam: oppositeTeam)
    }
    
    public func addStat(type: RecordableStats, player: Player?) {
        DispatchQueue.main.async {
            switch type {
            case .freeThrow:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    if self.isShotMade {
                        self.game?.yourTeam?.score += 1
                        self.game?.yourTeam?.players?[index].points += 1
                        self.game?.yourTeam?.players?[index].freeThrowAttempts += 1
                        self.game?.yourTeam?.players?[index].freeThrowMade += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    } else {
                        self.game?.yourTeam?.players?[index].freeThrowAttempts += 1
                        self.game?.yourTeam?.freeThrowAttempts += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    }
                } else {
                    if self.isShotMade {
                        self.game?.oppositeTeam?.score += 1
                        self.game?.oppositeTeam?.freeThrowAttempts += 1
                        self.game?.oppositeTeam?.freeThrowMade += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    } else {
                        self.game?.oppositeTeam?.freeThrowAttempts += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    }
                }
            case .twoPoints:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    if self.isShotMade {
                        self.game?.yourTeam?.score += 2
                        self.game?.yourTeam?.players?[index].points += 2
                        self.game?.yourTeam?.players?[index].twoPointAttempts += 1
                        self.game?.yourTeam?.players?[index].twoPointMade += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    } else {
                        self.game?.yourTeam?.players?[index].twoPointAttempts += 1
                        self.game?.yourTeam?.twoPointAttempts += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    }
                } else {
                    if self.isShotMade {
                        self.game?.oppositeTeam?.score += 2
                        self.game?.oppositeTeam?.twoPointAttempts += 1
                        self.game?.oppositeTeam?.twoPointMade += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    } else {
                        self.game?.oppositeTeam?.twoPointAttempts += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    }
                }
            case .threePoints:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    if self.isShotMade {
                        self.game?.yourTeam?.score += 3
                        self.game?.yourTeam?.players?[index].points += 3
                        self.game?.yourTeam?.players?[index].threePointAttempts += 1
                        self.game?.yourTeam?.players?[index].threePointMade += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    } else {
                        self.game?.yourTeam?.players?[index].threePointAttempts += 1
                        self.game?.yourTeam?.threePointAttempts += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    }
                } else {
                    if self.isShotMade {
                        self.game?.oppositeTeam?.score += 3
                        self.game?.oppositeTeam?.threePointAttempts += 1
                        self.game?.oppositeTeam?.threePointMade += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    } else {
                        self.game?.oppositeTeam?.threePointAttempts += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    }
                }
            case .rebond:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    if self.isDefensiveRebond {
                        self.game?.yourTeam?.players?[index].rebDef += 1
                        print(self.game?.yourTeam?.players?[index].rebDef ?? 0)
                    } else {
                        self.game?.yourTeam?.players?[index].rebOff += 1
                        print(self.game?.yourTeam?.players?[index].rebOff ?? 0)
                    }
                } else {
                    if self.isDefensiveRebond {
                        self.game?.oppositeTeam?.rebDef += 1
                        print(self.game?.oppositeTeam?.rebDef ?? 0)
                    } else {
                        self.game?.oppositeTeam?.rebOff += 1
                        print(self.game?.oppositeTeam?.rebOff ?? 0)
                    }
                }
            case .assist:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    self.game?.yourTeam?.players?[index].assists += 1
                    print(self.game?.yourTeam?.players?[index].assists ?? 0)
                } else {
                    self.game?.oppositeTeam?.assists += 1
                    print(self.game?.oppositeTeam?.assists ?? 0)
                }
                
//                self.showAddStatsSheet = false
//                self.shouldHighlightYourTeamButton = false
//                self.shouldHighlightOppositeTeamButton = false
            case .interception:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    self.game?.yourTeam?.players?[index].interceptions += 1
                    print(self.game?.yourTeam?.players?[index].interceptions ?? 0)
                } else {
                    self.game?.oppositeTeam?.interceptions += 1
                    print(self.game?.oppositeTeam?.interceptions ?? 0)
                }
            case .block:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    self.game?.yourTeam?.players?[index].blocks += 1
                    print(self.game?.yourTeam?.players?[index].blocks ?? 0)
                } else {
                    self.game?.oppositeTeam?.blocks += 1
                    print(self.game?.oppositeTeam?.blocks ?? 0)
                }
            case .personalFoul:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    self.game?.yourTeam?.players?[index].personalFoul += 1
                    print(self.game?.yourTeam?.players?[index].personalFoul ?? 0)
                } else {
                    self.game?.oppositeTeam?.fouls += 1
                    print(self.game?.oppositeTeam?.fouls ?? 0)
                }
            case .turnOver:
                if self.game?.yourTeam == self.addForTeam {
                    guard let plr = player else { return }
                    guard let index = self.game?.yourTeam?.players?.firstIndex(of: plr) else { return }
                    self.game?.yourTeam?.players?[index].turnovers += 1
                    print(self.game?.yourTeam?.players?[index].turnovers ?? 0)
                } else {
                    self.game?.oppositeTeam?.turnovers += 1
                    print(self.game?.oppositeTeam?.turnovers ?? 0)
                }
            }
            
            if !self.shouldDisplayAssistPicker {
                self.shouldHighlightYourTeamButton = false
                self.shouldHighlightOppositeTeamButton = false
            }
        }
    }
}
