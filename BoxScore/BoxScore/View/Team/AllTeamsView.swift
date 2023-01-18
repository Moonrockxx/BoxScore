//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI
import CoreData

struct AllTeamsView: View {
    
    func removeTeam(at offsets: IndexSet) {
        for index in offsets {
            let team = teams[index]
            viewContext.delete(team)
        }
    }
    
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) var teams: FetchedResults<BoxscoreTeam>
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        VStack {
            if teams.isEmpty {
                Text("No team regristred, add a new team")
            } else {
                List {
                    ForEach(teams, id: \.self) { item in
                        ZStack {
                            NavigationLink(destination:
                                            TeamDetailsView(viewModel: viewModel, item: item)
                                .environmentObject(controller)
                                .environment(\.managedObjectContext, controller.container.viewContext)) {
                                    EmptyView()
                                }
                                .opacity(0.0)
                            TeamRowView(item: item)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: removeTeam)
                }
                .listStyle(InsetListStyle())
            }
            Spacer()
        }
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
                environmentObject(controller)
                    .environment(\.managedObjectContext, controller.container.viewContext)
            }
        }
    }
}


struct AllTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTeamsView()
    }
}
