//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI
import CoreData

struct AllTeamsView: View {
    
//    func removeTeam(at offsets: IndexSet) {
//        for index in offsets {
//            let team = teams[index]
//            viewContext.delete(team)
//            
//            do {
//                try viewContext.save()
//            } catch {
//                print("Delete team produce an error")
//            }
//        }
//    }
//    
//    @EnvironmentObject var controller: DataController
//    @Environment(\.managedObjectContext) private var viewContext
//    
//    @FetchRequest(sortDescriptors: []) var teams: FetchedResults<BoxscoreTeam>
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        VStack {
            if viewModel.fetchedTeams.isEmpty {
                Text("No team regristred, add a new team")
            } else {
                List {
                    ForEach(viewModel.fetchedTeams, id: \.self) { item in
                        ZStack {
                            NavigationLink(destination: TeamDetailsView(viewModel: viewModel, item: item)) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                            TeamRowView(item: item)
                        }
                        .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                        .listRowSeparator(.hidden)
                    }
//                    .onDelete(perform: removeTeam)
                }
                .listStyle(InsetListStyle())
            }
            Spacer()
        }
        .alert(viewModel.error,
                isPresented: $viewModel.showTeamError,
                actions: {
             Button("OK", role: .cancel) { viewModel.showTeamError = false }
         })
        .onAppear(perform: {
            viewModel.fetchTeams()
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("All teams")
        .navigationBarItems(trailing:
                                Button {
            viewModel.showNewTeamSheet = true
        } label: {
            Image(systemName: "plus.circle")
                .tint(Color.subElement)
        })
        .sheet(isPresented: $viewModel.showNewTeamSheet) {
            NavigationView {
                NewTeamFormView(viewModel: viewModel)
            }
        }
    }
}


struct AllTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTeamsView()
    }
}
