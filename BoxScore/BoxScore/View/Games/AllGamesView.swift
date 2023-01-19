//
//  AllGamesView.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import SwiftUI

struct AllGamesView: View {
    func removeGame(at offsets: IndexSet) {
        for index in offsets {
            let game = games[index]
            viewContext.delete(game)
            
            do {
                try viewContext.save()
            } catch {
                print("Delete team produce an error")
            }
        }
    }
    
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) var games: FetchedResults<BoxscoreGame>
    
    @StateObject public var viewModel: AllGamesViewModel = AllGamesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.fetchedGames.isEmpty {
                Text("No games recorded yet")
            } else {
                List {
                    ForEach(viewModel.fetchedGames, id: \.id) { item in
                        ZStack {
//                            NavigationLink(destination:
//                                            TeamDetailsView(viewModel: viewModel, item: item)
//                                .environmentObject(controller)
//                                .environment(\.managedObjectContext, controller.container.viewContext)) {
//                                    EmptyView()
//                                }
//                                .opacity(0.0)
                            
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
            viewModel.gameMapper(for: games)
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
