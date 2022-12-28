//
//  TeamViewModel.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import Foundation

public class TeamViewModel: ObservableObject {
    
    //    public var teamName: String = ""
    public var teamSamples: [Team] = [Team(categorie: .u13 ,score: 0, isMenTeam: true, isMultipleTeams: false),
                                      Team(categorie: .u13 ,score: 0, isMenTeam: false, isMultipleTeams: false),
                                      Team(categorie: .u15 ,score: 0, isMenTeam: true, isMultipleTeams: false),
                                      Team(categorie: .u15 ,score: 0, isMenTeam: false, isMultipleTeams: false),
                                      Team(categorie: .u17 ,score: 0, isMenTeam: true, isMultipleTeams: false),
                                      Team(categorie: .u20 ,score: 0, isMenTeam: true, isMultipleTeams: false),
                                      Team(categorie: .s ,score: 0, isMenTeam: false, isMultipleTeams: false),
                                      Team(categorie: .s, players: [], games: [], teamNumber: "2", score: 0, isMenTeam: true, isMultipleTeams: true)]
    
    @Published public var categorie: Team.Categories = .u11
    @Published public var teamGender: Int = 0
    @Published public var teamNumber: String = ""
    @Published public var isMultipleTeams: Bool = false
    
    @Published public var playerName: String = ""
    @Published public var playerNumber: String = ""
    
    @Published public var showNewTeamSheet: Bool = false
    @Published public var showNewPlayerSheet: Bool = false
    
    public func fetchTeams() {
        // Core data fetch teams
    }
    
    public func saveTeam() {
        var team = Team(categorie: categorie,
                        players: [],
                        games: [],
                        teamNumber: teamNumber,
                        score: 0,
                        isMenTeam: teamGender == 0,
                        isMultipleTeams: isMultipleTeams)
        
        // Replace by core data add team management
        teamSamples.append(team)
        showNewTeamSheet = false
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


