//
//  NewGameTeamSelectionView.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import SwiftUI

struct NewGameTeamSelectionView: View {
    
    @ObservedObject public var viewModel: GameStatsViewModel = GameStatsViewModel()
    
    @State private var goToNextView: Bool = false
    
    // REMOVE BEFORE FLIGHT
    let teams: [Team] = [Team(id: UUID().uuidString, name: "U13 - M", score: 0, players: [], games: [], isMenTeam: true),
                         Team(id: UUID().uuidString, name: "U13 - F", score: 0, players: [], games: [], isMenTeam: false),
                         Team(id: UUID().uuidString, name: "U15 - M", score: 0, players: [], games: [], isMenTeam: true),
                         Team(id: UUID().uuidString, name: "U15 - F", score: 0, players: [], games: [], isMenTeam: false),
                         Team(id: UUID().uuidString, name: "U17 - M", score: 0, players: [], games: [], isMenTeam: true),
                         Team(id: UUID().uuidString, name: "U20 - M", score: 0, players: [], games: [], isMenTeam: true),
                         Team(id: UUID().uuidString, name: "SF1", score: 0, players: [], games: [], isMenTeam: false),
                         Team(id: UUID().uuidString,
                              name: "SG2",
                              score: 0,
                              players: [Player(firstName: "Kobe", lastName: "Bryant", number: "8"),
                                        Player(firstName: "Lebron", lastName: "James", number: "6"),
                                        Player(firstName: "Rudy", lastName: "Gobert", number: "32"),
                                        Player(firstName: "Michael", lastName: "Jordan", number: "23"),
                                        Player(firstName: "Chris", lastName: "Paul", number: "3"),
                                        Player(firstName: "Pau", lastName: "Gasol", number: "12"),
                                        Player(firstName: "Joel", lastName: "Embiid", number: "21"),
                                        Player(firstName: "Devin", lastName: "Booker", number: "1"),
                                        Player(firstName: "Thomas", lastName: "Ferré", number: "5")],
                              games: [],
                              isMenTeam: true)]
    
    @State private var multiSelection = Set<UUID>()
    
    var body: some View {
        Form {
            Section {
                Picker("Select your team", selection: $viewModel.selectedTeam) {
                    ForEach(teams, id: \.self) { team in
                        Text(team.name)
                    }
                }
                .pickerStyle(.menu)
                
                Picker("", selection: $viewModel.homeAwaySelection) {
                    Text("Home").tag(0)
                    Text("Away").tag(1)
                }
                .pickerStyle(.segmented)
            } header: {
                Text("Your team")
            }
            
            if viewModel.selectedTeam.name != "" {
                Section {
                    ForEach(viewModel.selectedTeam.players ?? [], id: \.id) { player in
                        PlayerRowSelectableView(item: player) {
                            if !viewModel.activePlayers.contains(where: { $0 == player }) {
                                viewModel.activePlayers.append(player)
                            } else {
                                let index = viewModel.activePlayers.firstIndex(of: player)
                                viewModel.activePlayers.remove(at: index ?? 0)
                            }
                        }
                    }
                } header: {
                    Text("Players active for \(viewModel.selectedTeam.name)")
                }
            }
            
            Section {
                TextField("Name", text: $viewModel.oppositeTeamName)
            } header: {
                Text("Opposite team")
            }
        }
        .navigationTitle("Pre-Game")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                                Button {
            self.goToNextView = true
        } label: {
            Text("Next")
                .foregroundColor(!viewModel.selectedTeam.name.isEmpty
                                 && !viewModel.oppositeTeamName.isEmpty
                                 && viewModel.oppositeTeamName != "" ? Color.subElement : Color.gray)
        }
            .disabled(!viewModel.selectedTeam.name.isEmpty
                      && !viewModel.oppositeTeamName.isEmpty
                      && viewModel.oppositeTeamName != "")
        )
    }
}

struct NewGameTeamSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameTeamSelectionView()
    }
}
