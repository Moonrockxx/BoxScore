//
//  AllGamesViewModel.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import Foundation
import SwiftUI
import CoreData

public class AllGamesViewModel: ObservableObject {
    
    let coreDataManager: CoreDataManager = CoreDataManager(managedObjectContext: CoreDataStack.shared.mainContext)
    
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
                                          yourTeam: game.yourTeam,
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
