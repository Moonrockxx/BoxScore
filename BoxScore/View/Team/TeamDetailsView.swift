//
//  TeamDetailsView.swift
//  BoxScore
//
//  Created by TomF on 14/12/2022.
//

import SwiftUI

struct TeamDetailsView: View {
    
    @ObservedObject public var viewModel: TeamViewModel
    public var item: Team
    
    var body: some View {
        VStack {
            if viewModel.fetchedPlayers.filter({ $0.teamId == item.id }).isEmpty {
                Spacer()
                
                NoDataView(text: "No player registred for this team")
                    .padding(.horizontal)
                
                Spacer()
            } else {
                List {
                    ForEach(viewModel.fetchedPlayers.filter({ $0.teamId == item.id })) { player in
                        HStack {
                            Text("\(player.firstName) \(player.lastName)")
                            Spacer()
                            Text("\(player.number)")
                                .padding(5)
                                .frame(width: 30)
                                .background(Color.subElement)
                                .foregroundColor(Color.text)
                                .clipShape(Capsule())
                        }
                    }
                    .onDelete(perform: removePlayer)
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchPlayers()
        })
        .onDisappear(perform: {
            viewModel.fetchedPlayers = []
        })
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

extension TeamDetailsView {
    func removePlayer(at offsets: IndexSet) {
        for index in offsets {
            let player = viewModel.fetchedPlayers[index]
            viewModel.coreDataManager.removePlayer(id: player.id)
            viewModel.fetchPlayers()
        }
    }
}
