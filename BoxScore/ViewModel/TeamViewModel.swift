//
//  TeamViewModel.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import CoreData
import Foundation

@MainActor
public class TeamViewModel: ObservableObject {
    
    let coreDataManager: CoreDataManager = CoreDataManager(managedObjectContext: CoreDataStack.shared.mainContext)
    
    public var teamSamples: [Team] = [Team(categorie: .s, name: "U20-M", players: [], games: [], teamNumber: "2", score: 0, isMenTeam: true, isMultipleTeams: true)]
    
    @Published public var categorie: Team.Categories = .u11
    @Published public var teamGender: Int = 0
    @Published public var teamNumber: String = ""
    @Published public var isMultipleTeams: Bool = false
    
    @Published public var playerName: String = ""
    @Published public var playerNumber: String = ""
    
    @Published public var showNewTeamSheet: Bool = false
    @Published public var showNewPlayerSheet: Bool = false
    @Published public var showTeamError: Bool = false
    
    @Published public var error: String = ""
    
    @Published public var fetchedPlayers: [Player] = []
    @Published public var fetchedTeams: [Team] = []
    
    
    public var teamId: UUID = UUID()
    
    init() {
        self.fetchTeams()
    }
    
    public func fetchPlayers() {
        self.fetchedPlayers = []
        coreDataManager.fetchPlayers { result in
            switch result {
            case .success(let players):
                players.forEach { bsPlayer in
                    let player = Player(id: bsPlayer.id ?? UUID(),
                                        teamId: bsPlayer.teamId ?? UUID(),
                                        firstName: bsPlayer.firstName ?? "",
                                        lastName: bsPlayer.lastName ?? "",
                                        number: bsPlayer.number ?? "",
                                        points: Int(bsPlayer.points),
                                        rebOff: Int(bsPlayer.rebOff),
                                        rebDef: Int(bsPlayer.rebDef),
                                        assists: Int(bsPlayer.assists),
                                        turnovers: Int(bsPlayer.turnovers),
                                        interceptions: Int(bsPlayer.interceptions),
                                        blocks: Int(bsPlayer.blocks),
                                        personalFoul: Int(bsPlayer.personalFoul),
                                        freeThrowAttempts: Int(bsPlayer.freeThrowAttempts),
                                        freeThrowMade: Int(bsPlayer.freeThrowMade),
                                        twoPointsAttempts: Int(bsPlayer.twoPointsAttempts),
                                        twoPointsMade: Int(bsPlayer.twoPointsMade),
                                        threePointsAttempts: Int(bsPlayer.threePointsAttempts),
                                        threePointsMade: Int(bsPlayer.threePointsMade))
                    
                    self.fetchedPlayers.append(player)
                }
            case .failure(let error):
                self.showTeamError = true
                self.error = error.localizedDescription
            }
        }
    }
    
    public func fetchTeams() {
        self.fetchedTeams = []
        DispatchQueue.main.async {
            self.coreDataManager.fetchTeam { result in
                switch result {
                case .success(let teams):
                    teams.forEach { bsTeam in
                        let team = Team(id: bsTeam.id ?? UUID(),
                                        clubName: bsTeam.clubName ?? "",
                                        categorie: Team.Categories(rawValue: bsTeam.categorie ?? "") ?? .s,
                                        name: bsTeam.name ?? "",
                                        players: self.fetchedPlayers.filter({ $0.teamId == self.teamId }),
                                        games: nil,
                                        teamNumber: bsTeam.teamNumber,
                                        score: Int(bsTeam.score),
                                        rebOff: Int(bsTeam.rebOff),
                                        rebDef: Int(bsTeam.rebDef),
                                        interceptions: Int(bsTeam.interceptions),
                                        assists: Int(bsTeam.assists),
                                        blocks: Int(bsTeam.blocks),
                                        turnovers: Int(bsTeam.turnovers),
                                        fouls: Int(bsTeam.fouls),
                                        freeThrowAttempts: Int(bsTeam.freeThrowAttempts),
                                        freeThrowMade: Int(bsTeam.freeThrowMade),
                                        twoPointsAttempts: Int(bsTeam.twoPointsAttempts),
                                        twoPointsMade: Int(bsTeam.twoPointsMade),
                                        threePointsAttempts: Int(bsTeam.threePointsAttempts),
                                        threePointsMade: Int(bsTeam.threePointsMade),
                                        isMenTeam: bsTeam.isMenTeam,
                                        isMultipleTeams: bsTeam.isMultipleTeam)
                        
                        self.fetchedTeams.append(team)
                    }
                case .failure(let error):
                    self.showTeamError = true
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    public func saveTeam() {
        DispatchQueue.main.async {
            let team = Team(categorie: self.categorie,
                            name: "\(self.categorie.rawValue) - \(self.teamGender == 0 ? "M" : "F") \(self.isMultipleTeams ? self.teamNumber : "")",
                            players: [],
                            games: [],
                            teamNumber: self.teamNumber,
                            score: 0,
                            isMenTeam: self.teamGender == 0,
                            isMultipleTeams: self.isMultipleTeams)
            
            self.coreDataManager.saveTeam(team: team, completionHandler: { result in
                switch result {
                case .success:
                    DispatchQueue.main.async {
                        self.fetchTeams()
                        self.showNewTeamSheet = false
                    }
                case .failure(let error):
                    self.showTeamError = true
                    self.error = error.localizedDescription
                }
            })
        }
    }
    
    public func savePlayer() {
        var player: Player = Player(teamId: UUID(), firstName: "", lastName: "", number: "")
        guard let number = Int(playerNumber) else { return }
        
        if !playerName.isEmpty, (0...100).contains(number) {
            player = Player(teamId: teamId,
                            firstName: playerName,
                            lastName: "",
                            number: playerNumber,
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
                            twoPointsAttempts: 0,
                            twoPointsMade: 0,
                            threePointsAttempts: 0,
                            threePointsMade: 0)
            
        } else {
            self.showTeamError = true
            self.error = "Player name can't be empty, his/her number must be contains between 0 and 100"
        }
        
        coreDataManager.savePlayer(player: player, completionHandler: { result in
            switch result {
            case .success:
                self.fetchPlayers()
                self.showNewPlayerSheet = false
            case .failure(let error):
                self.showTeamError = true
                self.error = error.localizedDescription
            }
        })
        
        self.playerName = ""
        self.playerNumber = ""
    }
}


