//
//  GameRowView.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import SwiftUI

struct GameRowView: View {
    public var item: Game
    public var image: String {
        if let team = item.yourTeam {
            return team.isMenTeam ? "menTeam" : "girlTeam"
        } else {
            return "N/A"
        }
    }
    public var offsetForImage: Double {
        if let team = item.yourTeam {
            return team.isMenTeam ? 40 : 0
        } else {
            return 0
        }
    }
    
    public var isGameWin: Bool {
        item.yourTeam?.score ?? 0 > item.oppositeTeam?.score ?? 0
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Spacer()
                if let yourTeam = item.yourTeam {
                    Text(yourTeam.name)
                        .foregroundColor(Color.text)
                        .font(.system(size: 22, weight: .semibold))
                }
                
                HStack {
                    Text(item.yourTeam?.clubName ?? "")
                    Text("\(item.yourTeam?.score ?? 0)")
                    Text(" - ")
                    Text("\(item.oppositeTeam?.score ?? 0)")
                    Text(item.oppositeTeam?.clubName ?? "")
                        
                }
                .foregroundColor(Color.text)
                .padding(.bottom)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Text("\(isGameWin ? "W" : "L")")
                .foregroundColor(isGameWin ? Color.green : Color.red)
                .padding(.trailing, 5)
            
            Image(systemName: "chevron.forward.circle")
                .renderingMode(.template)
                .foregroundColor(Color.text)
                .padding(.trailing, 5)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
        )
        .background(
            Image(image)
                .resizable()
                .saturation(0.2)
                .aspectRatio(contentMode: .fill)
                .offset(y: 40)
                .frame(height: 100)
                .clipped()
        )
        
        .frame(height: 100)
        .cornerRadius(8)
        //        .padding(.horizontal)
    }
}

//struct GameRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameRowView(item: Game(id: UUID(),
//                               yourTeam: Team(id: UUID(),
//                                              clubName: "So Carcassonne",
//                                              categorie: .s,
//                                              name: "Senior - M 2",
//                                              players: nil,
//                                              games: nil,
//                                              teamNumber: "2",
//                                              score: 2,
//                                              rebOff: 0,
//                                              rebDef: 0,
//                                              interceptions: 0,
//                                              assists: 0,
//                                              blocks: 0,
//                                              turnovers: 0,
//                                              fouls: 0,
//                                              freeThrowAttempts: 0,
//                                              freeThrowMade: 0,
//                                              twoPointsAttempts: 0,
//                                              twoPointsMade: 0,
//                                              threePointsAttempts: 0,
//                                              threePointsMade: 0,
//                                              freeThrowPercentage: 0,
//                                              twoPointsPercentage: 0,
//                                              threePointsPercentage: 0,
//                                              isMenTeam: true,
//                                              isMultipleTeams: true),
//                               oppositeTeam: Team(id: UUID(),
//                                                  clubName: "So Coursan",
//                                                  categorie: .s,
//                                                  name: "Senior - M 2",
//                                                  players: nil,
//                                                  games: nil,
//                                                  teamNumber: "2",
//                                                  score: 0,
//                                                  rebOff: 0,
//                                                  rebDef: 0,
//                                                  interceptions: 0,
//                                                  assists: 0,
//                                                  blocks: 0,
//                                                  turnovers: 0,
//                                                  fouls: 0,
//                                                  freeThrowAttempts: 0,
//                                                  freeThrowMade: 0,
//                                                  twoPointsAttempts: 0,
//                                                  twoPointsMade: 0,
//                                                  threePointsAttempts: 0,
//                                                  threePointsMade: 0,
//                                                  freeThrowPercentage: 0,
//                                                  twoPointsPercentage: 0,
//                                                  threePointsPercentage: 0,
//                                                  isMenTeam: true,
//                                                  isMultipleTeams: true)))
//    }
//}
