//
//  NewGameTeamSelectionView.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import SwiftUI

struct NewGameTeamSelectionView: View {
    
    @ObservedObject public var viewModel: GameStatsViewModel
    @State private var goToNextView: Bool = false
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Picker("Select your team", selection: $viewModel.selectedTeam) {
                        ForEach(viewModel.fetchedTeams, id: \.self) {
                            Text($0.name)
                                .tag($0)
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
                
                if let players = viewModel.selectedTeam.players,
                   viewModel.shouldShowActivePlayersList {
                    Section {
                        ForEach(players, id: \.id) { player in
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
            .background(Color.white)
            .adaptsToKeyboard()
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
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            viewModel.fetchTeams()
        }
        .onDisappear {
            viewModel.fetchedTeams = []
        }
    }
}

struct NewGameTeamSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NewGameTeamSelectionView(viewModel: GameStatsViewModel())
    }
}
