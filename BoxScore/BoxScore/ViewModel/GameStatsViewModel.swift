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
}

public enum FlowType: Int, CaseIterable {
    case pregame
    case recorder
    case final
    
    public var title: String {
        switch self {
        case .pregame:
            return "Pre-game"
        case .recorder:
            return "Recorder"
        case .final:
            return "Stats"
        }
    }
}

public class GameStatsViewModel: ObservableObject {
    let coreDataManager: CoreDataManager = CoreDataManager(managedObjectContext: CoreDataStack.shared.mainContext)
    
    //MARK: Variables
    @Published public var flowType: FlowType = .pregame
    @Published public var selectedTeam: Team = Team(categorie: .s, name: "", score: 0, isMenTeam: false, isMultipleTeams: false) {
        didSet {
            if let players = selectedTeam.players {
                shouldShowActivePlayersList = !players.isEmpty
            } else {
                shouldShowActivePlayersList = false
            }
        }
    }
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
    @Published public var shouldShowActivePlayersList: Bool = false
    @Published public var goToFinalView: Bool = false
    @Published public var dismissRecorderFlow: Bool = false
    
    @Published public var sheetType: RecordableStats = .freeThrow
    
    @Published public var game: Game?
    @Published public var fetchedTeams: [Team] = []
    @Published public var fetchedPlayers: [Player] = []
    
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
        self.fetchPlayers()
        self.fetchTeams()
    }
    
    //MARK: Functions
    @ViewBuilder
    public func view(type: FlowType, viewModel: GameStatsViewModel) -> some View {
        switch type {
        case .pregame:
            NewGameTeamSelectionView(viewModel: viewModel)
        case .recorder:
            StatsRecorderView(viewModel: viewModel)
        case .final:
            FinalGameStatView(viewModel: viewModel, item: self.game ?? Game())
        }
    }
    
    public func startNewGame() {
        guard let categorie = selectedTeam.categorie else { return }
        guard let categorieName = selectedTeam.categorie?.rawValue else { return }
        guard let teamNumber = selectedTeam.teamNumber else { return }
        
        self.yourTeam = Team(clubName: clubName,
                             categorie: categorie,
                             name: "\(categorieName) - \(selectedTeam.isMenTeam ? "M" : "F") \(selectedTeam.isMultipleTeams ? teamNumber : "")",
                             players: activePlayers,
                             games: nil,
                             teamNumber: teamNumber,
                             score: 0,
                             isMenTeam: selectedTeam.isMenTeam,
                             isMultipleTeams: false)
        
        self.oppositeTeam = Team(clubName: oppositeTeamName,
                                 categorie: selectedTeam.categorie ?? Team.Categories(rawValue: "")!,
                                 name: oppositeTeamName,
                                 players: nil,
                                 games: nil,
                                 teamNumber: nil,
                                 score: 0,
                                 isMenTeam: selectedTeam.isMenTeam,
                                 isMultipleTeams: false)
        
        self.game = Game(yourTeam: yourTeam, oppositeTeam: oppositeTeam)
        self.flowType = .recorder
    }
    
    public func fetchTeams() {
        fetchPlayers()
        coreDataManager.fetchTeam { result in
            switch result {
            case .success(let teams):
                teams.forEach { team in
                    let fetchedTeam = Team(id: team.id ?? UUID(),
                                           clubName: team.clubName ?? "",
                                           categorie: Team.Categories(rawValue: team.categorie ?? "") ?? Team.Categories(rawValue: "")!,
                                           name: team.name ?? "",
                                           players: [],
                                           games: [],
                                           teamNumber: team.teamNumber,
                                           isMenTeam: team.isMenTeam,
                                           isMultipleTeams: team.isMultipleTeam)
                    
                    self.fetchedPlayers.filter({ $0.teamId == fetchedTeam.id }).forEach { player in
                        fetchedTeam.players?.append(player)
                    }
                    
                    self.fetchedTeams.append(fetchedTeam)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func fetchPlayers() {
        coreDataManager.fetchPlayers { result in
            switch result {
            case .success(let players):
                players.forEach { player in
                    let fetchedPlayer = Player(id: player.id ?? UUID(),
                                               teamId: player.teamId ?? UUID(),
                                               firstName: player.firstName ?? "",
                                               lastName: player.lastName ?? "",
                                               number: player.number ?? "",
                                               points: Int(player.points),
                                               rebOff: Int(player.rebOff),
                                               rebDef: Int(player.rebDef),
                                               assists: Int(player.assists),
                                               turnovers: Int(player.turnovers),
                                               interceptions: Int(player.interceptions),
                                               blocks: Int(player.blocks),
                                               personalFoul: Int(player.personalFoul),
                                               freeThrowAttempts: player.freeThrowAttempts,
                                               freeThrowMade: player.freeThrowMade,
                                               twoPointAttempts: player.twoPointsAttempts,
                                               twoPointMade: player.twoPointsMade,
                                               threePointAttempts: player.threePointsAttempts,
                                               threePointMade: player.threePointsMade,
                                               freeThrowPercentage: player.freeThrowPercentage,
                                               twoPointPercentage: player.twoPointsPercentage,
                                               threePointPercentage: player.threePointsPercentage)
                    
                    self.fetchedPlayers.append(fetchedPlayer)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func saveGame() {
        if let game = self.game {
            coreDataManager.saveGame(game: game)
        }
    }
    
    public func backToDashboard() {
        self.dismissRecorderFlow = true
        self.flowType = .pregame
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
                        self.game?.yourTeam?.twoPointsAttempts += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    }
                } else {
                    if self.isShotMade {
                        self.game?.oppositeTeam?.score += 2
                        self.game?.oppositeTeam?.twoPointsAttempts += 1
                        self.game?.oppositeTeam?.twoPointsMade += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    } else {
                        self.game?.oppositeTeam?.twoPointsAttempts += 1
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
                        self.game?.yourTeam?.threePointsAttempts += 1
                        print(self.game?.yourTeam?.players?[index].points ?? 0)
                    }
                } else {
                    if self.isShotMade {
                        self.game?.oppositeTeam?.score += 3
                        self.game?.oppositeTeam?.threePointsAttempts += 1
                        self.game?.oppositeTeam?.threePointsMade += 1
                        print(self.game?.oppositeTeam?.score ?? 0)
                    } else {
                        self.game?.oppositeTeam?.threePointsAttempts += 1
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
