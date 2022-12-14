//
//  TeamDetailsView.swift
//  BoxScore
//
//  Created by TomF on 14/12/2022.
//

import SwiftUI

struct TeamDetailsView: View {
    
    @StateObject public var viewModel: TeamViewModel
    public var item: Team
    
    var body: some View {
        ScrollView {
            if ((item.players?.isEmpty) != nil) {
                Text("Add new players to build your team")
            } else {
                ForEach(item.players!) { player in
                    HStack {
                        Text("\(player.number)")
                        Text("\(player.firstName) \(player.lastName)")
                    }
                }
            }
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button {
            viewModel.showNewPlayerSheet = true
        } label: {
            Image(systemName: "plus.circle")
                .tint(Color.subElement)
        })
        .sheet(isPresented: $viewModel.showNewPlayerSheet) {
            NavigationView {
                NewPlayerFormView(viewModel: viewModel, item: item)
            }
        }
    }
}

struct TeamDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailsView(viewModel: TeamViewModel(), item: Team(id: "", name: "U17 - M", score: 0, players: [], games: [], isMenTeam: true))
    }
}
