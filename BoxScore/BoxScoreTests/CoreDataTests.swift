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
    private var gameSample2: Game?
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
        self.gameSample2 = Game(id: UUID(),
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
    func testRemoveAGame() {
        guard let game = gameSample1 else { return }
        coreDataManager.removeAllGames()
        
        coreDataManager.saveGame(game: game,
                                 completionHandler: { result in
            switch result {
            case .success(let savedGame):
                self.bsGames.append(savedGame)
            case .failure(let failure):
                print("❌ TEST - Save game before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.removeGame(id: self.bsGames.first?.id ?? UUID())
        
        self.bsGames = []
        
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
        
        XCTAssertTrue(self.bsGames.isEmpty)
    }
    
    // Remove All
    func testRemoveAllGames() {
        guard let game1 = gameSample1 else { return }
        guard let game2 = gameSample1 else { return }
        coreDataManager.removeAllGames()
        
        coreDataManager.saveGame(game: game1,
                                 completionHandler: { result in
            switch result {
            case .success(let savedGame):
                self.bsGames.append(savedGame)
            case .failure(let failure):
                print("❌ TEST - Save game before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.saveGame(game: game2,
                                 completionHandler: { result in
            switch result {
            case .success(let savedGame):
                self.bsGames.append(savedGame)
            case .failure(let failure):
                print("❌ TEST - Save game before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.removeAllGames()
        
        self.bsGames = []
        
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
        
        XCTAssertTrue(self.bsGames.isEmpty)
    }
    
    //MARK: Teams
    // Save
    func testSaveATeam() {
        coreDataManager.removeAllTeams()
        
        coreDataManager.saveTeam(team: self.teamSample1) { result in
            switch result {
            case .success(let team):
                self.bsTeams.append(team)
            case .failure(let failure):
                print("❌ TEST - Save team : \(failure.title)")
            }
        }
        
        guard let teamSaved = self.bsTeams.first else { return }
        XCTAssertEqual(teamSaved.id, teamSample1.id)
    }
    
    // Fetch
    func testFetchTeams() {
        coreDataManager.removeAllTeams()
        
        coreDataManager.saveTeam(team: teamSample1,
                                 completionHandler: { result in
            switch result {
            case .success:
                print("✅ TEST - Save team before fetch")
            case .failure(let failure):
                print("❌ TEST - Save team before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.fetchTeam { result in
            switch result {
            case .success(let teams):
                teams.forEach { team in
                    self.bsTeams.append(team)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch teams : \(failure.title)")
            }
        }
        
        guard let teamSaved = self.bsTeams.first else { return }
        XCTAssertEqual(teamSaved.id, self.teamSample1.id)
    }
    
    // Remove
    func testRemoveATeam() {
        coreDataManager.removeAllTeams()
        
        coreDataManager.saveTeam(team: teamSample1,
                                 completionHandler: { result in
            switch result {
            case .success(let savedTeam):
                self.bsTeams.append(savedTeam)
            case .failure(let failure):
                print("❌ TEST - Save team before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.removeTeam(id: self.bsTeams.first?.id ?? UUID())
        
        self.bsTeams = []
        
        coreDataManager.fetchTeam { result in
            switch result {
            case .success(let teams):
                teams.forEach { team in
                    self.bsTeams.append(team)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch teams : \(failure.title)")
            }
        }
        
        XCTAssertTrue(self.bsTeams.isEmpty)
    }
    
    // Remove All
    func testRemoveAllTeams() {
        coreDataManager.removeAllTeams()
        
        coreDataManager.saveTeam(team: self.teamSample1,
                                 completionHandler: { result in
            switch result {
            case .success(let savedTeam):
                self.bsTeams.append(savedTeam)
            case .failure(let failure):
                print("❌ TEST - Save team before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.saveTeam(team: teamSample2,
                                 completionHandler: { result in
            switch result {
            case .success(let savedTeam):
                self.bsTeams.append(savedTeam)
            case .failure(let failure):
                print("❌ TEST - Save team before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.removeAllTeams()
        
        self.bsTeams = []
        
        coreDataManager.fetchTeam { result in
            switch result {
            case .success(let teams):
                teams.forEach { team in
                    self.bsTeams.append(team)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch teams : \(failure.title)")
            }
        }
        
        XCTAssertTrue(self.bsTeams.isEmpty)
    }
    
    //MARK: Players
    // Save
    func testSaveAPlayer() {
        guard let player1 = self.playerSample1 else { return }
        coreDataManager.removeAllPlayers()
        
        coreDataManager.savePlayer(player: player1) { result in
            switch result {
            case .success(let player):
                self.bsPlayers.append(player)
            case .failure(let failure):
                print("❌ TEST - Save player : \(failure.title)")
            }
        }
        
        guard let playerSaved = self.bsPlayers.first else { return }
        XCTAssertEqual(playerSaved.id, playerSample1?.id)
    }
    
    // Fetch
    func testFetchPlayers() {
        guard let player1 = self.playerSample1 else { return }
        coreDataManager.removeAllPlayers()
        
        coreDataManager.savePlayer(player: player1,
                                   completionHandler: { result in
            switch result {
            case .success:
                print("✅ TEST - Save player before fetch")
            case .failure(let failure):
                print("❌ TEST - Save player before fetch : \(failure.title)")
            }
        })
        
        coreDataManager.fetchPlayers { result in
            switch result {
            case .success(let players):
                players.forEach { player in
                    self.bsPlayers.append(player)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch players : \(failure.title)")
            }
        }
        
        guard let playerSaved = self.bsPlayers.first else { return }
        XCTAssertEqual(playerSaved.id, self.playerSample1?.id)
    }
    
    // Remove
    func testRemoveAPlayer() {
        guard let player1 = self.playerSample1 else { return }
        coreDataManager.removeAllPlayers()
        
        coreDataManager.savePlayer(player: player1) { result in
            switch result {
            case .success(let player):
                self.bsPlayers.append(player)
            case .failure(let failure):
                print("❌ TEST - Save player : \(failure.title)")
            }
        }
        
        coreDataManager.removePlayer(id: self.bsPlayers.first?.id ?? UUID())
        
        self.bsPlayers = []
        
        coreDataManager.fetchPlayers { result in
            switch result {
            case .success(let players):
                players.forEach { player in
                    self.bsPlayers.append(player)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch players : \(failure.title)")
            }
        }
        
        XCTAssertTrue(self.bsPlayers.isEmpty)
    }
    
    // Remove All
    func testRemoveAllPlayers() {
        guard let player1 = self.playerSample1 else { return }
        coreDataManager.removeAllPlayers()
        
        coreDataManager.savePlayer(player: player1) { result in
            switch result {
            case .success(let player):
                self.bsPlayers.append(player)
            case .failure(let failure):
                print("❌ TEST - Save player : \(failure.title)")
            }
        }
        
        coreDataManager.savePlayer(player: player1) { result in
            switch result {
            case .success(let player):
                self.bsPlayers.append(player)
            case .failure(let failure):
                print("❌ TEST - Save player : \(failure.title)")
            }
        }
        
        coreDataManager.removeAllPlayers()
        
        self.bsPlayers = []
        
        coreDataManager.fetchPlayers { result in
            switch result {
            case .success(let players):
                players.forEach { player in
                    self.bsPlayers.append(player)
                }
            case .failure(let failure):
                print("❌ TEST - Fetch players : \(failure.title)")
            }
        }
        
        XCTAssertTrue(self.bsPlayers.isEmpty)
    }
}
