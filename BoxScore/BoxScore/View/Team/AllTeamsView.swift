//
//  AllTeamsView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI

struct AllTeamsView: View {
    
    
    
    @StateObject public var viewModel: TeamViewModel = TeamViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.teamSamples) { item in
                TeamRowView(item: item)
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
