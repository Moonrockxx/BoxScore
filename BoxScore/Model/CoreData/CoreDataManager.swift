//
//  CoreDataManager.swift
//  BoxScore
//
//  Created by TomF on 26/01/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    enum CDErrors: Error {
        case noData
        case saveError
    }
    
    let managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    //MARK: Players
    func savePlayer(player: Player, completionHandler: @escaping (Result<BoxscorePlayer, CDErrors>) -> Void) {
        let entity = BoxscorePlayer(context: managedObjectContext)
        entity.id = player.id
        entity.teamId = player.teamId
        entity.firstName = player.firstName
        entity.lastName = player.lastName
        entity.number = player.number
        entity.points = Int64(player.points)
        entity.rebOff = Int64(player.rebOff)
        entity.rebDef = Int64(player.rebDef)
        entity.assists = Int64(player.assists)
        entity.turnovers = Int64(player.turnovers)
        entity.interceptions = Int64(player.interceptions)
        entity.blocks = Int64(player.blocks)
        entity.personalFoul = Int64(player.personalFoul)
        entity.freeThrowAttempts = Int64(player.freeThrowAttempts)
        entity.freeThrowMade = Int64(player.freeThrowMade)
        entity.twoPointsAttempts = Int64(player.twoPointsAttempts)
        entity.twoPointsMade = Int64(player.twoPointsMade)
        entity.threePointsAttempts = Int64(player.threePointsAttempts)
        entity.threePointsMade = Int64(player.threePointsMade)
        
        do {
            try CoreDataStack.shared.mainContext.save()
            completionHandler(.success(entity))
        } catch {
            print(error)
            completionHandler(.failure(.saveError))
        }
    }
    
    func removePlayer(id: UUID) {
        let fetchRequest: NSFetchRequest<BoxscorePlayer> = BoxscorePlayer.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let result = try? managedObjectContext.fetch(fetchRequest)
        if let bsPlayer = result?.first(where: { $0.id == id }) {
            managedObjectContext.delete(bsPlayer)
            do {
                try managedObjectContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchPlayers(completionHandler: @escaping (Result<[BoxscorePlayer], CDErrors>) -> Void) {
        let request: NSFetchRequest = BoxscorePlayer.fetchRequest()
        
        do {
            let fetchedPlayers = try managedObjectContext.fetch(request)
            return completionHandler(.success(fetchedPlayers))
        } catch {
            print("Fetch teams fails with error : \(error.localizedDescription)")
            return completionHandler(.failure(.noData))
        }
    }
    
    func removeAllPlayers() {
        let fetchRequest: NSFetchRequest<BoxscorePlayer> = BoxscorePlayer.fetchRequest()
        let result = try? managedObjectContext.fetch(fetchRequest)
        
        if let results = result {
            for i in results {
                managedObjectContext.delete(i)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    //MARK: Game
    func saveGame(game: Game, completionHandler: @escaping (Result<BoxscoreGame, CDErrors>) -> Void) {
        let entity = BoxscoreGame(context: managedObjectContext)
        entity.id = game.id
        entity.yourTeam = game.yourTeam
        entity.oppositeTeam = game.oppositeTeam
        
        do {
            try CoreDataStack.shared.mainContext.save()
            completionHandler(.success(entity))
        } catch {
            print(error)
            completionHandler(.failure(.saveError))
        }
    }
    
    func removeGame(id: UUID) {
        let fetchRequest: NSFetchRequest<BoxscoreGame> = BoxscoreGame.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let result = try? managedObjectContext.fetch(fetchRequest)
        if let bsGame = result?.first(where: { $0.id == id }) {
            managedObjectContext.delete(bsGame)
            do {
                try managedObjectContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchGames(completionHandler: @escaping (Result<[BoxscoreGame], CDErrors>) -> Void) {
        let request: NSFetchRequest = BoxscoreGame.fetchRequest()
        
        do {
            let fetchedGames = try managedObjectContext.fetch(request)
            return completionHandler(.success(fetchedGames))
        } catch {
            print("Fetch games fails with error : \(error.localizedDescription)")
            return completionHandler(.failure(.noData))
        }
    }
    
    func removeAllGames() {
        let fetchRequest: NSFetchRequest<BoxscoreGame> = BoxscoreGame.fetchRequest()
        let result = try? managedObjectContext.fetch(fetchRequest)
        
        if let results = result {
            for i in results {
                managedObjectContext.delete(i)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: Team
    func saveTeam(team: Team, completionHandler: @escaping (Result<BoxscoreTeam, CDErrors>) -> Void)  {
        DispatchQueue.main.async {
            let entity = BoxscoreTeam(context: self.managedObjectContext)
            entity.id = team.id
            entity.clubName = team.clubName
            entity.categorie = team.categorie?.rawValue
            entity.name = team.name
            entity.teamNumber = team.teamNumber
            entity.score = Int64(team.score)
            entity.rebOff = Int64(team.rebOff)
            entity.rebDef = Int64(team.rebDef)
            entity.interceptions = Int64(team.interceptions)
            entity.assists = Int64(team.assists)
            entity.blocks = Int64(team.blocks)
            entity.turnovers = Int64(team.turnovers)
            entity.fouls = Int64(team.fouls)
            entity.freeThrowAttempts = Int64(team.freeThrowAttempts)
            entity.freeThrowMade = Int64(team.freeThrowMade)
            entity.twoPointsAttempts = Int64(team.twoPointsAttempts)
            entity.twoPointsMade = Int64(team.twoPointsMade)
            entity.threePointsAttempts = Int64(team.threePointsAttempts)
            entity.threePointsMade = Int64(team.threePointsMade)
            entity.isMenTeam = team.isMenTeam
            entity.isMultipleTeam = team.isMultipleTeams
            
            do {
                try self.managedObjectContext.save()
                completionHandler(.success(entity))
            } catch {
                print(error)
                completionHandler(.failure(.saveError))
            }
        }
    }
    
    func removeTeam(id: UUID) {
        let fetchRequest: NSFetchRequest<BoxscoreTeam> = BoxscoreTeam.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        let result = try? managedObjectContext.fetch(fetchRequest)
        if let bsTeam = result?.first(where: { $0.id == id }) {
            managedObjectContext.delete(bsTeam)
            do {
                try managedObjectContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTeam(completionHandler: @escaping (Result<[BoxscoreTeam], CDErrors>) -> Void) {
        DispatchQueue.main.async {
            let request: NSFetchRequest = BoxscoreTeam.fetchRequest()
            
            do {
                let fetchedTeams = try self.managedObjectContext.fetch(request)
                return completionHandler(.success(fetchedTeams))
            } catch {
                print("Fetch teams fails with error : \(error.localizedDescription)")
                return completionHandler(.failure(.noData))
            }
        }
    }
    
    func removeAllTeams() {
        let fetchRequest: NSFetchRequest<BoxscoreTeam> = BoxscoreTeam.fetchRequest()
        let result = try? managedObjectContext.fetch(fetchRequest)
        
        if let results = result {
            for i in results {
                managedObjectContext.delete(i)
            }
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
