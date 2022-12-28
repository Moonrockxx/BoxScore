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
    
    public var statType: RecordableStats
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                Text("For which team ?")
                    .font(.system(size: 18, weight: .bold))
                
                HStack {
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
                }
            }
            .padding()
            
            if viewModel.shouldDisplayToogle {
                VStack {
                    if viewModel.sheetType == .rebond {
                        Toggle("Defensive rebond ?", isOn: $viewModel.isDefensiveRebond)
                    } else {
                        Toggle("Shot successful ?", isOn: $viewModel.isShotMade)
                    }
                }
                .padding()
            }
            
            if showPlayersList {
                VStack(alignment: .leading) {
                    Text("For which player ?")
                        .font(.system(size: 18, weight: .bold))
                    
                    List {
                        ForEach(viewModel.addForTeam?.players ?? [], id: \.id) { player in
                            PlayerRowSelectableView(isInGame: true, item: player) {
                                // Add stat for the players
                                self.viewModel.showAddStatsSheet = false
                            }
                            .listRowSeparatorTint(Color.subElement)
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    .background(Color.element)
                }
                .padding()
            }
            
            Spacer()
        }
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

struct StatSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StatSheetView(viewModel: GameStatsViewModel(), statType: .freeThrow)
    }
}
