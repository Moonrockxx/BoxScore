//
//  DashboardViewModel.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import Foundation

public class DashboardViewModel: ObservableObject {
    let coreDataManager: CoreDataManager = CoreDataManager(managedObjectContext: CoreDataStack.shared.mainContext)
    public var menuElements: [MenuElements] = [MenuElements(id: UUID().uuidString, title: "Record a new game", image: "match", imageOffset: 40, linkValue: .newGame),
                                               MenuElements(id: UUID().uuidString, title: "See all games", image: "game", imageOffset: -57, linkValue: .allGames),
                                               MenuElements(id: UUID().uuidString, title: "Manage teams", image: "team", imageOffset: 0, linkValue: .teams)]
    
    
    let gameSamples: [Game] = [Game(id: UUID(),
                                    yourTeam: Team(id: UUID(), clubName: "SO Carcassonne", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: true),
                                    oppositeTeam: Team(id: UUID(), clubName: "SO Coursan", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: false)),
                               Game(id: UUID(),
                                    yourTeam: Team(id: UUID(), clubName: "SO Carcassonne", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: true),
                                    oppositeTeam: Team(id: UUID(), clubName: "SO Coursan", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: false)),
                               Game(id: UUID(),
                                    yourTeam: Team(id: UUID(), clubName: "SO Carcassonne", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: true),
                                    oppositeTeam: Team(id: UUID(), clubName: "SO Coursan", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: false)),
                               Game(id: UUID(),
                                    yourTeam: Team(id: UUID(), clubName: "SO Carcassonne", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: true),
                                    oppositeTeam: Team(id: UUID(), clubName: "SO Coursan", categorie: .s, name: "", players: nil, games: nil, teamNumber: "2", score: 0, rebOff: 0, rebDef: 0, interceptions: 0, assists: 0, blocks: 0, turnovers: 0, fouls: 0, freeThrowAttempts: 0, freeThrowMade: 0, twoPointsAttempts: 0, twoPointsMade: 0, threePointsAttempts: 0, threePointsMade: 0, freeThrowPercentage: 0, twoPointsPercentage: 0, threePointsPercentage: 0, isMenTeam: true, isMultipleTeams: false)),
    ]
    
    @Published public var fetchedGames: [Game] = []
    @Published public var error: String = ""
    @Published public var showError: Bool = false
    
    public func fetchGames() {
        self.fetchedGames = []
        
        self.coreDataManager.fetchGames { result in
            switch result {
            case .success(let games):
                games.forEach { game in
                    let mappedGame = Game(id: game.id ?? UUID(),
                                          yourTeam: game.yourTeam,
                                          oppositeTeam: game.oppositeTeam)
                    
                    self.fetchedGames.append(mappedGame)
                }
            case .failure(let error):
                self.showError = true
                self.error = error.localizedDescription
            }
        }
    }
}


public struct MenuElements: Identifiable, Hashable {
    public enum ElementsValue {
        case newGame
        case allGames
        case teams
    }
    
    public var id: String
    public var title: String
    public var image: String
    public var imageOffset: Double
    public var linkValue: ElementsValue
}
