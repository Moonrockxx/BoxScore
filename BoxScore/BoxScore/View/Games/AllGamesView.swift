//
//  AllGamesView.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import SwiftUI

struct AllGamesView: View {
    
    @StateObject public var viewModel: AllGamesViewModel = AllGamesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.fetchedGames.isEmpty {
                Text("No games recorded yet")
            } else {
                List {
                    ForEach(viewModel.fetchedGames, id: \.id) { item in
                        ZStack {
                            NavigationLink {
                                FinalGameStatView(viewModel: GameStatsViewModel(), item: item)
                            } label: {
                                EmptyView()
                            }
                            .opacity(0.0)
                            
                            GameRowView(item: item)
                            
                        }
                        .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: removeGame)
                }
                .listStyle(InsetListStyle())
            }
            Spacer()
        }
        .onAppear {
            viewModel.fetchGames()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("All games")
    }
}

struct AllGamesView_Previews: PreviewProvider {
    static var previews: some View {
        AllGamesView()
    }
}

extension AllGamesView {
    func removeGame(at offsets: IndexSet) {
        for index in offsets {
            let game = viewModel.fetchedGames[index]
            viewModel.coreDataManager.removeGame(id: game.id)
        }
    }
}
