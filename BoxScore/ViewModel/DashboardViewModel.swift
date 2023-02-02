//
//  DashboardViewModel.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import Foundation

public class DashboardViewModel: ObservableObject {
    let coreDataManager: CoreDataManager = CoreDataManager(managedObjectContext: CoreDataStack.shared.mainContext)
    public var menuElements: [MenuElements] = [MenuElements(id: UUID().uuidString,
                                                            title: "Record a new game",
                                                            image: "match",
                                                            imageOffset: 40,
                                                            linkValue: .newGame),
                                               MenuElements(id: UUID().uuidString,
                                                            title: "See all games",
                                                            image: "game",
                                                            imageOffset: -57,
                                                            linkValue: .allGames),
                                               MenuElements(id: UUID().uuidString,
                                                            title: "Manage teams",
                                                            image: "team",
                                                            imageOffset: 0,
                                                            linkValue: .teams)]
    
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
                                          yourTeam: Team(id: game.yourTeam?.id ?? UUID(),
                                                         clubName: game.yourTeam?.clubName ?? "",
                                                         categorie: Team.Categories(rawValue: game.yourTeam?.categorie?.rawValue ?? "") ?? Team.Categories(rawValue: "")!,
                                                         name: game.yourTeam?.name ?? "",
                                                         players: game.yourTeam?.players,
                                                         games: nil,
                                                         teamNumber: game.yourTeam?.teamNumber,
                                                         score: game.yourTeam?.score ?? 0,
                                                         rebOff: game.yourTeam?.rebOff ?? 0,
                                                         rebDef: game.yourTeam?.rebDef ?? 0,
                                                         interceptions: game.yourTeam?.interceptions ?? 0,
                                                         assists: game.yourTeam?.assists ?? 0,
                                                         blocks: game.yourTeam?.blocks ?? 0,
                                                         turnovers: game.yourTeam?.turnovers ?? 0,
                                                         fouls: game.yourTeam?.fouls ?? 0,
                                                         freeThrowAttempts: game.yourTeam?.freeThrowAttempts ?? 0,
                                                         freeThrowMade: game.yourTeam?.freeThrowMade ?? 0,
                                                         twoPointsAttempts: game.yourTeam?.twoPointsAttempts ?? 0,
                                                         twoPointsMade: game.yourTeam?.twoPointsMade ?? 0,
                                                         threePointsAttempts: game.yourTeam?.threePointsAttempts ?? 0,
                                                         threePointsMade: game.yourTeam?.threePointsMade ?? 0,
                                                         isMenTeam: game.yourTeam?.isMenTeam ?? true,
                                                         isMultipleTeams: game.yourTeam?.isMultipleTeams ?? true),
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
