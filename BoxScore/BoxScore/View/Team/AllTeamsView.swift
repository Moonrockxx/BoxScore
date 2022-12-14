//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI

struct AllTeamsView: View {
    
    public var teamSamples: [Team] = [Team(id: UUID().uuidString, name: "U13 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "U13 - F", score: 0, players: [], games: [], isMenTeam: false),
                                      Team(id: UUID().uuidString, name: "U15 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "U15 - F", score: 0, players: [], games: [], isMenTeam: false),
                                      Team(id: UUID().uuidString, name: "U17 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "U20 - M", score: 0, players: [], games: [], isMenTeam: true),
                                      Team(id: UUID().uuidString, name: "SF1", score: 0, players: [], games: [], isMenTeam: false),
                                      Team(id: UUID().uuidString, name: "SG2", score: 0, players: [], games: [], isMenTeam: true)]
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    @State private var showSheet: Bool = false
    
    var body: some View {
        ScrollView {
            ForEach(teamSamples) { item in
                TeamRowView(item: item)
            }
        }
        .padding(.top, 25)
        .background(Color.white)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("All teams")
        .navigationBarItems(trailing:
                                Button {
            self.showSheet = true
        } label: {
            Image(systemName: "plus.circle")
                .tint(Color.subElement)
        })
    }
}


struct AllTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTeamsView()
    }
}
