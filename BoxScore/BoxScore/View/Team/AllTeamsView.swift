//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI
import CoreData

struct AllTeamsView: View {
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: []) var teams: FetchedResults<BoxscoreTeam>
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        VStack {
            if teams.isEmpty {
                Text("No team regristred, add a new team")
            } else {
                ForEach(teams) { item in
                    NavigationLink(destination:
                                    TeamDetailsView(viewModel: viewModel, item: item)
                        
                        .environmentObject(controller)
                        .environment(\.managedObjectContext, controller.container.viewContext)) {
                            TeamRowView(item: item)
                        }
                }
            }
            Spacer()
        }
        .padding(.top, 25)
        .background(Color.white)
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
