//
//  NewTeamFormView.swift
//  BoxScore
//
//  Created by TomF on 14/12/2022.
//

import SwiftUI

struct NewTeamFormView: View {
    
    @StateObject public var viewModel: TeamViewModel
    
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Form {
            Section {
                Picker("Select a categorie", selection: $viewModel.categorie) {
                    ForEach(Team.Categories.allCases, id: \.self) { cat in
                        Text(cat.rawValue)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("Team gender", selection: $viewModel.teamGender) {
                    Text("Male").tag(0)
                    Text("Female").tag(1)
                }
                .pickerStyle(.segmented)
                
                Toggle("Categorie multiple teams ?", isOn: $viewModel.isMultipleTeams)
                
                if viewModel.isMultipleTeams {
                    TextField("Team number", text: $viewModel.teamNumber)
                }
            } header: {
                Text("Team information")
            }
        }
        .navigationTitle("New team")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action: {
             viewModel.saveTeam(closure: { team in
                 let newTeam = BoxscoreTeam(context: viewContext)
                 newTeam.id = team.id
                 newTeam.clubName = team.clubName
                 newTeam.categorie = team.categorie.rawValue
                 newTeam.name = team.name
                 newTeam.teamNumber = team.teamNumber
                 newTeam.isMenTeam = team.isMenTeam
                 newTeam.isMultipleTeam = team.isMultipleTeams
                 
                 try? viewContext.save()
             })
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
