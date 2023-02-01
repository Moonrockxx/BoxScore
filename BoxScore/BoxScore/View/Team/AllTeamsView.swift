//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI
import CoreData

struct AllTeamsView: View {
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        VStack {
            if viewModel.fetchedTeams.isEmpty {
                Spacer()
                
                NoDataView(text: "No team registred yet")
            } else {
                List {
                    ForEach(viewModel.fetchedTeams, id: \.id) { item in
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
                    .onDelete(perform: removeTeam)
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

extension AllTeamsView {
    func removeTeam(at offsets: IndexSet) {
        for index in offsets {
            let team = viewModel.fetchedTeams[index]
            viewModel.coreDataManager.removeTeam(id: team.id)
            viewModel.fetchTeams()
        }
    }
}
