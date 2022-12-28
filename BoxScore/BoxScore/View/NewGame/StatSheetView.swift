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
                            viewModel.addForTeam = viewModel.game?.yourTeam
                            self.viewModel.shouldHighlightYourTeamButton = true
                            self.showPlayersList = true
                        }
                    } label: {
                        Text(viewModel.game?.yourTeam?.clubName ?? "")
                            .foregroundColor(Color.text)
                    }
                    .frame(width: 150, height: 75)
                    .padding(.horizontal)
                    .background(viewModel.shouldHighlightYourTeamButton ? Color.subElement : Color.element)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    
                    Spacer()
                    
                    Button {
                        DispatchQueue.main.async {
                            viewModel.shouldHighlightOppositeTeamButton = true
                            viewModel.addForTeam = viewModel.game?.oppositeTeam
                            viewModel.addStat(type: statType, player: nil)
                            viewModel.showAddStatsSheet = false
                        }
                    } label: {
                        Text(viewModel.game?.oppositeTeam?.clubName ?? "")
                            .foregroundColor(Color.text)
                    }
                    .frame(width: 150, height: 75)
                    .padding(.horizontal)
                    .background(viewModel.shouldHighlightOppositeTeamButton ? Color.subElement : Color.element)
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
                    
                    if viewModel.sheetType == .twoPoints || viewModel.sheetType == .threePoints {
                        Toggle("Is there an assist ?", isOn: $viewModel.shouldDisplayAssistPicker)
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
                                viewModel.addStat(type: statType, player: player)
                                
                                if !viewModel.shouldDisplayAssistPicker {
                                    self.viewModel.showAddStatsSheet = false
                                }
                            }
                            .listRowSeparatorTint(Color.subElement)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.element)
                }
                .padding()
            }
            
            if viewModel.shouldDisplayAssistPicker {
                VStack(alignment: .leading) {
                    Text("Assist from which player ?")
                        .font(.system(size: 18, weight: .bold))
                    
                    List {
                        ForEach(viewModel.addForTeam?.players ?? [], id: \.id) { player in
                            PlayerRowSelectableView(isInGame: true, item: player) {
                                viewModel.addStat(type: .assist, player: player)
                                self.viewModel.showAddStatsSheet = false
                                self.viewModel.shouldDisplayAssistPicker = false
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
