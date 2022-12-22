//
//  GameStatsViewModel.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import Foundation

public class GameStatsViewModel: ObservableObject {
    @Published public var selectedTeam: Team = Team(id: "", name: "", score: 0, isMenTeam: false)
    @Published public var homeAwaySelection: Int = 0
    @Published public var oppositeTeamName: String = ""
    
    private var isHomeGame: Bool {
        return homeAwaySelection == 0
    }
    
    public var activePlayers: [Player] = []
    
}
