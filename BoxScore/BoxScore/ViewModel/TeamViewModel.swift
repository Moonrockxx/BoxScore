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
    @Published public var showNewTeamSheet: Bool = false
    
    public func fetchTeams() {
        // Core data fetch teams
    }
    
    public func saveTeam() {
        if !teamName.isEmpty {
            let team = Team(id: UUID().uuidString,
                            name: teamName,
                            score: 0,
                            players: [],
                            games: [],
                            isMenTeam: teamGender == 0)
            
            // Replace by core data add team management
            teamSamples.append(team)
            showNewTeamSheet = false
        }
    }
}


