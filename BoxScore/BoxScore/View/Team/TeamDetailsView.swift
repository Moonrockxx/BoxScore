//
//  TeamDetailsView.swift
//  BoxScore
//
//  Created by TomF on 14/12/2022.
//

import SwiftUI

struct TeamDetailsView: View {
    
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject public var viewModel: TeamViewModel
    public var item: BoxscoreTeam
    
    var body: some View {
        ScrollView {
            if item.players == nil {
                Text("Add new players to build your team")
            } else {
                ForEach(item.players as? [Player] ?? []) { player in
                    HStack {
                        Text("\(player.number)")
                        Text("\(player.firstName) \(player.lastName)")
                    }
                }
            }
        }
        .navigationTitle(item.name ?? "")
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
                    .environmentObject(controller)
                    .environment(\.managedObjectContext, controller.container.viewContext)
            }
        }
    }
}

//struct TeamDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamDetailsView(viewModel: TeamViewModel(), item: Team(categorie: .u17 ,score: 0, isMenTeam: true, isMultipleTeams: false))
//    }
//}
