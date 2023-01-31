//
//  CoreDataTests.swift
//  BoxScoreTests
//
//  Created by TomF on 30/01/2023.
//

import XCTest
import CoreData
@testable import BoxScore

final class CoreDataTests: XCTestCase {
    
    var coreDataManager: CoreDataManager!
    var coreDataStack: CoreDataStack!
    
    private var bsGames: [BoxscoreGame] = []
    private var bsPlayers: [BoxscorePlayer] = []
    private var bsTeams: [BoxscoreTeam] = []
    
    
    private var gameSample1: Game?
    private var playerSample1: Player?
    private var playerSample2: Player?
    private var teamSample1: Team = Team(id: UUID(),
                                         clubName: "SO Carcassonne",
                                         categorie: .s,
                                         name: "Senior - M 2",
                                         players: nil,
                                         games: nil,
                                         teamNumber: "2",
                                         score: 0,
                                         rebOff: 0,
                                         rebDef: 0,
                                         interceptions: 0,
                                         assists: 0,
                                         blocks: 0,
                                         turnovers: 0,
                                         fouls: 0,
                                         freeThrowAttempts: 0,
                                         freeThrowMade: 0,
                                         twoPointsAttempts: 0,
                                         twoPointsMade: 0,
                                         threePointsAttempts: 0,
                                         threePointsMade: 0,
                                         freeThrowPercentage: 0,
                                         twoPointsPercentage: 0,
                                         threePointsPercentage: 0,
                                         isMenTeam: true,
                                         isMultipleTeams: true)
    private var teamSample2: Team = Team(id: UUID(),
                                         clubName: "St-Esteve Basket",
                                         categorie: .s,
                                         name: "Senior - M 2",
                                         players: nil,
                                         games: nil,
                                         teamNumber: "2",
                                         score: 0,
                                         rebOff: 0,
                                         rebDef: 0,
                                         interceptions: 0,
                                         assists: 0,
                                         blocks: 0,
                                         turnovers: 0,
                                         fouls: 0,
                                         freeThrowAttempts: 0,
                                         freeThrowMade: 0,
                                         twoPointsAttempts: 0,
                                         twoPointsMade: 0,
                                         threePointsAttempts: 0,
                                         threePointsMade: 0,
                                         freeThrowPercentage: 0,
                                         twoPointsPercentage: 0,
                                         threePointsPercentage: 0,
                                         isMenTeam: true,
                                         isMultipleTeams: true)
    
    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataStack(modelName: "Boxscore", persistentStoreDescription: "/dev/null")
        coreDataManager = CoreDataManager()
        self.playerSample1 = Player(id: UUID(),
                                    teamId: self.teamSample1.id,
                                    firstName: "Thomas F",
                                    lastName: "Thomas F",
                                    number: "8",
                                    points: 0,
                                    rebOff: 0,
                                    rebDef: 0,
                                    assists: 0,
                                    turnovers: 0,
                                    interceptions: 0,
                                    blocks: 0,
                                    personalFoul: 0,
                                    freeThrowAttempts: 0,
                                    freeThrowMade: 0,
                                    twoPointAttempts: 0,
                                    twoPointMade: 0,
                                    threePointAttempts: 0,
                                    threePointMade: 0,
                                    freeThrowPercentage: 0,
                                    twoPointPercentage: 0,
                                    threePointPercentage: 0)
        self.playerSample2 = Player(id: UUID(),
                                    teamId: self.teamSample1.id,
                                    firstName: "Ali B",
                                    lastName: "Ali B",
                                    number: "10",
                                    points: 0,
                                    rebOff: 0,
                                    rebDef: 0,
                                    assists: 0,
                                    turnovers: 0,
                                    interceptions: 0,
                                    blocks: 0,
                                    personalFoul: 0,
                                    freeThrowAttempts: 0,
                                    freeThrowMade: 0,
                                    twoPointAttempts: 0,
                                    twoPointMade: 0,
                                    threePointAttempts: 0,
                                    threePointMade: 0,
                                    freeThrowPercentage: 0,
                                    twoPointPercentage: 0,
                                    threePointPercentage: 0)
        self.gameSample1 = Game(id: UUID(),
                                yourTeam: teamSample1,
                                oppositeTeam: teamSample2)
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataStack = nil
        coreDataManager = nil
        self.bsGames = []
        self.bsTeams = []
        self.bsPlayers = []
    }
    
    //MARK: Games
    // Save
    func testSaveAGame() {
        guard let game = gameSample1 else { return }
        coreDataManager.removeAllGames()
        
        coreDataManager.saveGame(game: game,
                                      completionHandler: { result in
            switch result {
            case .success(let game):
                self.bsGames.append(game)
            case .failure(let failure):
                print("❌ TEST - Save game : \(failure.title)")
            }
        })
        
        let gameSaved = self.bsGames.first
        XCTAssertEqual(gameSaved?.id, gameSample1?.id)
    }
    
    // Fetch
    func testFetchSavedGames() {
        guard let game = gameSample1 else { return }
        coreDataManager.removeAllGames()
        
        coreDataManager.saveGame(game: game,
                                      completionHandler: { result in
            switch result {
            case .success:
                print("✅ TEST - Save game before fetch")
            case .failure(let failure):
                print("❌ TEST - Save game before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.fetchGames { result in
            switch result {
            case .success(let games):
                games.forEach { game in
                    self.bsGames.append(game)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch games : \(failure.title)")
            }
        }
        
        XCTAssertTrue(self.bsGames.count == 1)
        XCTAssertEqual(self.bsGames.first?.id, self.gameSample1?.id)
    }
    
    
    // Remove
    
    
    // Remove All
    
    //MARK: Teams
    // Save
    
    // Fetch
    
    // Remove
    
    // Remove All
    
    
    //MARK: Players
    // Save
    
    // Fetch
    
    // Remove
    
    // Remove All
}
