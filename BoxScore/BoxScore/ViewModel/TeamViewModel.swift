//
//  TeamViewModel.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import CoreData
import Foundation

public class TeamViewModel: ObservableObject {
    
    //    public var teamName: String = ""
    public var teamSamples: [Team] = [Team(categorie: .s, name: "U20-M", players: [], games: [], teamNumber: "2", score: 0, isMenTeam: true, isMultipleTeams: true)]
    
    @Published public var categorie: Team.Categories = .u11
    @Published public var teamGender: Int = 0
    @Published public var teamNumber: String = ""
    @Published public var isMultipleTeams: Bool = false
    
    @Published public var playerName: String = ""
    @Published public var playerNumber: String = ""
    
    @Published public var showNewTeamSheet: Bool = false
    @Published public var showNewPlayerSheet: Bool = false
    
    public var teamId: UUID = UUID()
    
    public func saveTeam(closure: (Team) -> ()) {
        let team = Team(categorie: categorie,
                        name: "\(categorie.rawValue) - \(teamGender == 0 ? "M" : "F") \(isMultipleTeams ? teamNumber : "")",
                        players: [],
                        games: [],
                        teamNumber: teamNumber,
                        score: 0,
                        isMenTeam: teamGender == 0,
                        isMultipleTeams: isMultipleTeams)
        
        closure(team)
        teamSamples.append(team)
        showNewTeamSheet = false
    }
    
    public func savePlayer(team: BoxscoreTeam, closure: (Player) -> ()) {
        guard let number = Int(playerNumber) else { return }
        
        if !playerName.isEmpty, (0...100).contains(number) {
            let player = Player(teamId: teamId,
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
                                twoPointAttempts: 0,
                                twoPointMade: 0,
                                threePointAttempts: 0,
                                threePointMade: 0,
                                freeThrowPercentage: 0,
                                twoPointPercentage: 0,
                                threePointPercentage: 0)
            
            closure(player)
            
            showNewPlayerSheet = false
            playerName = ""
            playerNumber = ""
        } else {
            // display error
        }
    }
    
}


