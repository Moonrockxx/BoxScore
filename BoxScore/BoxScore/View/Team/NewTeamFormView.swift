//
//  NewTeamFormView.swift
//  BoxScore
//
//  Created by TomF on 14/12/2022.
//

import SwiftUI

struct NewTeamFormView: View {
    
    @StateObject public var viewModel: TeamViewModel
    
    var body: some View {
        Form {
            Section {
                TextField("Team name", text: $viewModel.teamName)
                
                Picker("Team gender", selection: $viewModel.teamGender) {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Team information")
            }
        }
        .navigationTitle("New team")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
             viewModel.saveTeam()
        }, label: {
            Text("Save")
                .foregroundColor(Color.subElement)
        }))
    }
}

struct NewTeamFormView_Previews: PreviewProvider {
    static var previews: some View {
        NewTeamFormView(viewModel: TeamViewModel())
    }
}
