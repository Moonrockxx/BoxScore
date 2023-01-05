//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI

struct AllTeamsView: View {
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.teamSamples.isEmpty {
                Text("No team regristred, add a new team")
            } else {
                ForEach(viewModel.teamSamples) { item in
                    NavigationLink(destination:
                                    TeamDetailsView(viewModel: viewModel, item: item)
                        .environmentObject(controller)
                        .environment(\.managedObjectContext, controller.container.viewContext)) {
                            TeamRowView(item: item)
                        }
                }
            }
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
            }
        }
    }
}


struct AllTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        AllTeamsView()
    }
}
