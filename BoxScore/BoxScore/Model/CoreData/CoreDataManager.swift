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
        entity.points = Int32(player.points)
        entity.rebOff = Int32(player.rebOff)
        entity.rebDef = Int32(player.rebDef)
        entity.assists = Int32(player.assists)
        entity.turnovers = Int32(player.turnovers)
        entity.interceptions = Int32(player.interceptions)
        entity.blocks = Int32(player.blocks)
        entity.personalFoul = Int32(player.personalFoul)
        entity.freeThrowAttempts = player.freeThrowAttempts
        entity.freeThrowMade = player.freeThrowMade
        entity.twoPointsAttempts = player.twoPointAttempts
        entity.twoPointsMade = player.twoPointMade
        entity.threePointsAttempts = player.threePointAttempts
        entity.threePointsMade = player.threePointMade
        entity.freeThrowPercentage = player.freeThrowPercentage ?? 0
        entity.twoPointsPercentage = player.twoPointPercentage ?? 0
        entity.threePointsPercentage = player.threePointPercentage ?? 0
        
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
    
    func playerAlreadySaved(id: UUID, firstName: String) -> Bool {
        let request: NSFetchRequest<BoxscorePlayer> = BoxscorePlayer.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        request.predicate = NSPredicate(format: "firstName == %@", firstName)
        
        guard let player = try? managedObjectContext.fetch(request) else { return false }
        
        return !player.isEmpty
    }
    
    
    //MARK: Game
    func saveGame(game: Game) {
        let entity = BoxscoreGame(context: managedObjectContext)
        entity.id = game.id
        entity.yourTeam = game.yourTeam
        entity.oppositeTeam = game.oppositeTeam
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            print(error)
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
            entity.freeThrowPercentage = Int64(team.freeThrowPercentage)
            entity.twoPointsPercentage = Int64(team.twoPointsPercentage)
            entity.threePointsPercentage = Int64(team.threePointsPercentage)
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
}
