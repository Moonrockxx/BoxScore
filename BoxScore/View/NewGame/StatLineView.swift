//
//  StatLineView.swift
//  BoxScore
//
//  Created by TomF on 24/01/2023.
//

import SwiftUI

struct StatLineView: View {
    
    public var playerItem: Player?
    
    var body: some View {
        if let player = playerItem {
            HStack {
                FirstStatLineGroup(player: player)
                SecondStatLineGroup(player: player)
                ThirdStatLineGroup(player: player)
                LastStatLineGroup(player: player)
            }
        }
    }
}

struct FirstStatLineGroup: View {
    public var player: Player
    
    var body: some View {
        Group {
            
            Text("\(player.points)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.rebDef)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.rebOff)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
        }
    }
}

struct SecondStatLineGroup: View {
    public var player: Player
    
    var body: some View {
        Group {
            Text("\(player.rebOff + player.rebDef)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.assists)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.blocks)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.interceptions)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.turnovers)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
        }
    }
}

struct ThirdStatLineGroup: View {
    public var player: Player
    
    var body: some View {
        Group {
            Text("\(player.personalFoul)")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("\(player.freeThrowMade)/\(player.freeThrowAttempts)")
                .frame(width: 100)
            
            Spacer(minLength: 25)
            
            if player.freeThrowAttempts == 0 {
                Text("0%")
                    .frame(width: 100)
            } else {
                Text("\((player.freeThrowMade / player.freeThrowAttempts) * 100)%")
                    .frame(width: 100)
            }
            
            
            Spacer(minLength: 25)
            
            Text("\(player.twoPointsMade)/\(player.twoPointsAttempts)")
                .frame(width: 100)
            
            Spacer(minLength: 25)
        }
    }
}

struct LastStatLineGroup: View {
    public var player: Player
    
    var body: some View {
        Group {
            if player.twoPointsAttempts == 0 {
                Text("0%")
                    .frame(width: 100)
            } else {
                Text("\((player.twoPointsMade / player.twoPointsAttempts) * 100)%")
                    .frame(width: 100)
            }
            
            Spacer(minLength: 25)
            
            Text("\(player.threePointsMade)/\(player.threePointsAttempts)")
                .frame(width: 100)
            
            Spacer(minLength: 25)
            
            if player.threePointsAttempts == 0 {
                Text("0%")
                    .frame(width: 100)
            } else {
                Text("\((player.threePointsMade / player.threePointsAttempts) * 100)%")
                    .frame(width: 100)
            }
        }
    }
}

struct NumberAndNameGroupView: View {
    public var player: Player
    
    var body: some View {
        HStack {
            Text(player.number)
                .frame(width: 30)
            
            Spacer(minLength: 10)
            
            Text(player.firstName)
                .frame(width: 150)
                .lineLimit(1)
            
            Spacer(minLength: 25)
        }
    }
}

struct StatLineView_Previews: PreviewProvider {
    static var previews: some View {
        StatLineView(playerItem: Player(id: UUID(),
                                        teamId: UUID(),
                                        firstName: "Thomas Ferré",
                                        lastName: "Thomas Ferré",
                                        number: "8",
                                        points: 11,
                                        rebOff: 2,
                                        rebDef: 5,
                                        assists: 10,
                                        turnovers: 2,
                                        interceptions: 3,
                                        blocks: 2,
                                        personalFoul: 4,
                                        freeThrowAttempts: 0,
                                        freeThrowMade: 0,
                                        twoPointsAttempts: 2,
                                        twoPointsMade: 1,
                                        threePointsAttempts: 4,
                                        threePointsMade: 3)
    )}
}



