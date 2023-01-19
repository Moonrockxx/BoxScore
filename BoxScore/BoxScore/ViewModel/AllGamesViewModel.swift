//
//  AllGamesViewModel.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import Foundation
import SwiftUI

public class AllGamesViewModel: ObservableObject {
    @Published public var fetchedGames: [Game] = []
    
    public func gameMapper(for games: FetchedResults<BoxscoreGame>) {
        games.forEach { game in
            let mappedGame = Game(id: game.id ?? UUID(),
                                  yourTeam: game.yourTeam,
                                  oppositeTeam: game.oppositeTeam)
            
            fetchedGames.append(mappedGame)
        }
    }
}
