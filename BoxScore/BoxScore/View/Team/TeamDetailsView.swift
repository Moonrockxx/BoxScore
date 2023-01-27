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
        VStack {
//            if item.players == nil {
//                Text("Add new players to build your team")
//            } else {
            List {
//                ForEach(players.filter({ $0.teamId == item.id })) { player in
//                    HStack {
//                        Text("\(player.firstName ?? "") \(player.lastName ?? "")")
//                        Spacer()
//                        Text("\(player.number ?? "")")
//                            .padding(5)
//                            .background(Color.subElement)
//                            .foregroundColor(Color.text)
//                            .clipShape(Capsule())
//                    }
//                }
//                .onDelete(perform: removePlayer)
            }
//            }
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

//struct TeamDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamDetailsView(viewModel: TeamViewModel(), item: Team(categorie: .u17 ,score: 0, isMenTeam: true, isMultipleTeams: false))
//    }
//}
