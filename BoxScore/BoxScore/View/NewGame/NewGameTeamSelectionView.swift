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
    let teams: [Team] = [Team(categorie: .u11, players: [], games: [], score: 0, isMenTeam: true, isMultipleTeams: false),
                         Team(categorie: .u13, players: [], games: [], score: 0, isMenTeam: false, isMultipleTeams: false),
                         Team(categorie: .u13, players: [], games: [], score: 0, isMenTeam: true, isMultipleTeams: false),
                         Team(categorie: .u15, players: [], games: [], score: 0, isMenTeam: false, isMultipleTeams: false),
                         Team(categorie: .u17, players: [], games: [], score: 0, isMenTeam: true, isMultipleTeams: false),
                         Team(categorie: .u20, players: [], games: [], score: 0, isMenTeam: true, isMultipleTeams: false),
                         Team(categorie: .s, players: [], games: [], score: 0, isMenTeam: false, isMultipleTeams: false),
                         Team(categorie: .s ,players: [Player(firstName: "Kobe", lastName: "Bryant", number: "8"),
                                                       Player(firstName: "Lebron", lastName: "James", number: "6"),
                                                       Player(firstName: "Rudy", lastName: "Gobert", number: "32"),
                                                       Player(firstName: "Michael", lastName: "Jordan", number: "23"),
                                                       Player(firstName: "Chris", lastName: "Paul", number: "3"),
                                                       Player(firstName: "Pau", lastName: "Gasol", number: "12"),
                                                       Player(firstName: "Joel", lastName: "Embiid", number: "21"),
                                                       Player(firstName: "Devin", lastName: "Booker", number: "1"),
                                                       Player(firstName: "Thomas", lastName: "Ferr??", number: "5")],
                              games: [],
                              score: 0,
                              isMenTeam: true,
                              isMultipleTeams: false)]
    
    var body: some View {
        VStack {
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
                
                if ((viewModel.selectedTeam.players?.isEmpty) != nil) {
                    Section {
                        ForEach(viewModel.selectedTeam.players ?? [], id: \.id) { player in
                            PlayerRowSelectableView(isInGame: false, item: player) {
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
                self.viewModel.startNewGame()
            } label: {
                Text("Next")
                    .foregroundColor(viewModel.shouldGoNext ? Color.subElement : Color.gray)
            }
                .disabled(!viewModel.shouldGoNext)
            )
            
            NavigationLink("", isActive: $goToNextView) {
                StatsRecorderView(viewModel: viewModel)
            }
            .hidden()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct NewGameTeamSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameTeamSelectionView()
    }
}
