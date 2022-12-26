//
//  StatSheetView.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import SwiftUI

struct StatSheetView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    @State private var showPlayersList: Bool = false
    
    var body: some View {
        
        Form {
            Section {
                HStack {
                    Spacer()
                    
                    Button {
                        DispatchQueue.main.async {
                            viewModel.addForTeam = viewModel.game?.homeTeam
                            self.showPlayersList = true
                        }
                        
                    } label: {
                        Text(viewModel.game?.homeTeam?.clubName ?? "")
                            .foregroundColor(Color.text)
                    }
                    .frame(width: 150, height: 75)
                    .padding(.horizontal)
                    .background(Color.element)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    
                    Spacer()
                    
                    Button {
                        DispatchQueue.main.async {
                            viewModel.addForTeam = viewModel.game?.awayTeam
                            self.showPlayersList = true
                        }
                        
                    } label: {
                        Text(viewModel.game?.awayTeam?.clubName ?? "")
                            .foregroundColor(Color.text)
                    }
                    .frame(width: 150, height: 75)
                    .padding(.horizontal)
                    .background(Color.element)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    Spacer()
                }
            } header: {
                HStack {
                    Text("For which team ?")
                    Spacer()
                }
                
            }
            
            if showPlayersList {
                Section {
                    List {
                        ForEach(viewModel.addForTeam?.players ?? [], id: \.id) { player in
                            PlayerRowSelectableView(isInGame: true, item: player) {
                                // Add stat for the players
                                self.viewModel.showAddStatsSheet = false
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("For which player ?")
                        Spacer()
                    }
                }
            }
        }
        //        VStack {
        //            VStack {
        //                Section {
        //                    HStack {
        //                        Spacer()
        //
        //                        Button {
        //                            viewModel.addForTeam = viewModel.game?.homeTeam
        //                            self.showPlayersList = true
        //                        } label: {
        //                            Text(viewModel.game?.homeTeam?.clubName ?? "")
        //                                .foregroundColor(Color.text)
        //                        }
        //                        .frame(width: 150, height: 75)
        //                        .padding(.horizontal)
        //                        .background(Color.element)
        //                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        //
        //                        Spacer()
        //
        //                        Button {
        //                            viewModel.addForTeam = viewModel.game?.awayTeam
        //                            self.showPlayersList = true
        //                        } label: {
        //                            Text(viewModel.game?.awayTeam?.clubName ?? "")
        //                                .foregroundColor(Color.text)
        //                        }
        //                        .frame(width: 150, height: 75)
        //                        .padding(.horizontal)
        //                        .background(Color.element)
        //                        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        //                        Spacer()
        //                    }
        //                } header: {
        //                    HStack {
        //                        Text("For which team ?")
        //                            .font(.system(size: 18, weight: .semibold))
        //                        Spacer()
        //                    }
        //
        //                }
        //
        //                if showPlayersList {
        //                    Section {
        //                        VStack(spacing: 14) {
        //                            ForEach(viewModel.addForTeam?.players ?? [], id: \.id) { player in
        //                                PlayerRowSelectableView(isInGame: true, item: player) {
        //                                    // Add stat for the players
        //                                    self.viewModel.showAddStatsSheet = false
        //                                }
        //                            }
        //                        }
        //                        .padding()
        //                        .background(Color.gray.opacity(0.5))
        //                        .cornerRadius(8)
        //                    } header: {
        //                        HStack {
        //                            Text("For which player ?")
        //                                .font(.system(size: 18, weight: .semibold))
        //                            Spacer()
        //                        }
        //                        .padding(.top, 40)
        //                    }
        //                }
        //            }
        //            .padding()
        //
        //            Spacer()
        //        }
    }
}

struct StatSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StatSheetView(viewModel: GameStatsViewModel())
    }
}
