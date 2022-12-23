//
//  NewPlayerFormView.swift
//  BoxScore
//
//  Created by TomF on 14/12/2022.
//

import SwiftUI

struct NewPlayerFormView: View {
    
    @StateObject public var viewModel: TeamViewModel
    public var item: Team
    
    var body: some View {
        Form {
            Section {
                TextField("Player name", text: $viewModel.playerName)
                
                TextField("Number", text: $viewModel.playerNumber)
            } header: {
                Text("Player informations")
            }
        }
        .navigationTitle("New player")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
            viewModel.savePlayer(team: item)
        }, label: {
            Text("Save")
                .foregroundColor(Color.subElement)
        }))
    }
}

struct NewPlayerFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewPlayerFormView(viewModel: TeamViewModel(), item: Team(categorie: .u17 ,score: 0, isMenTeam: true, isMultipleTeams: false))
    }
}
