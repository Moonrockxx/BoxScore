//
//  TeamViewModel.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public class TeamViewModel: ObservableObject {
    
    public var teamSamples: [Team] = [Team(id: UUID().uuidString, name: "U13 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "U13 - F", score: 0, players: [], games: [], isMenTeam: false),
                                      Team(id: UUID().uuidString, name: "U15 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "U15 - F", score: 0, players: [], games: [], isMenTeam: false),
                                      Team(id: UUID().uuidString, name: "U17 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "U20 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "SF1", score: 0, players: [], games: [], isMenTeam: false),
                                      Team(id: UUID().uuidString, name: "SG2", score: 0, players: [], games: [], isMenTeam: true)]
    
    @Published public var teamName: String = ""
    @Published public var teamGender: Int = 0
    
    @Published public var playerName: String = ""
    @Published public var playerNumber: String = ""
    
    @Published public var showNewTeamSheet: Bool = false
    @Published public var showNewPlayerSheet: Bool = false
    
    public func fetchTeams() {
        // Core data fetch teams
    }
    
    public func saveTeam() {
        if !teamName.isEmpty {
            var team = Team(id: UUID().uuidString,
                            name: teamName,
                            score: 0,
                            players: [],
                            games: [],
                            isMenTeam: teamGender == 0)
            
            // Replace by core data add team management
            teamSamples.append(team)
            showNewTeamSheet = false
        } else {
            // display error
        }
    }
    
    public func fetchPlayers() {
        // Core data fetch players
    }
    
    public func savePlayer(team: Team) {
        guard let number = Int(playerNumber) else { return }
        
        if !playerName.isEmpty, (0...100).contains(number) {
            let player = Player(firstName: "Tom", lastName: "Ferré", number: "8")
            
            // Replace by core data add player management
            //TODO: Resolver Cannot use mutating member on immutable value: 'team' is a 'let' constant
//            team.players.append(player)
            showNewPlayerSheet = false
        } else {
            // display error
        }
    }
}


