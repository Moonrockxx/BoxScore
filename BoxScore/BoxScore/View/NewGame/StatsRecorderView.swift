//
//  StatsRecorderView.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import SwiftUI

struct StatsRecorderView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    @State private var showSheet: Bool = false
    
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                if let yourTeam = viewModel.yourTeam {
                    Text("\(yourTeam.categorie.rawValue) - \(yourTeam.isMenTeam ? "M" : "F")")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color.subElement)
                        .clipShape(Capsule())
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text(viewModel.clubName)
                        Text("\(viewModel.game?.yourTeam?.score ?? 0)")
                            .padding(.horizontal, 16)
                            .background(Color.subElement)
                            .clipShape(Capsule())
                    }
                    .frame(width: 150)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text(viewModel.oppositeTeamName)
                        Text("\(viewModel.game?.oppositeTeam?.score ?? 0)")
                            .padding(.horizontal, 16)
                            .background(Color.subElement)
                            .clipShape(Capsule())
                    }
                    .frame(width: 150)
                    
                    Spacer()
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.element)
                .clipShape(Capsule())
            }
            .padding()
            .background(Color.background)
            .foregroundColor(Color.text)
            
            
            VStack(spacing: 15) {
                HStack(spacing: 30) {
                    Spacer()
                    
                    ForEach(viewModel.pointsRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            viewModel.sheetType = item
                            showSheet = true
                        })
                    }
                    
                    Spacer()
                }
                .frame(height: 75)
                
                HStack(spacing: 30) {
                    Spacer()
                    
                    ForEach(viewModel.secondRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            viewModel.sheetType = item
                            showSheet = true
                        })
                    }
                    
                    Spacer()
                }
                .frame(height: 75)
                
                HStack(spacing: 30) {
                    Spacer()
                    
                    ForEach(viewModel.thirdRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            viewModel.sheetType = item
                            showSheet = true
                        })
                    }
                    
                    Spacer()
                }
                .frame(height: 75)
            }
            .padding()
            
            Spacer()
            
            // Add stats leaders for PTS, AST, REB
            
            NavigationLink("", isActive: $viewModel.goToFinalView) {
                FinalGameStatView(viewModel: viewModel)
            }
            .hidden()
        }
        .navigationBarItems(trailing:
                                Button {
            viewModel.saveGame(closure: { game in
                let newGame = BoxscoreGame(context: viewContext)
                newGame.id = game.id
                newGame.yourTeam = game.yourTeam
                newGame.oppositeTeam = game.oppositeTeam
                
                do {
                    try viewContext.save()
                } catch {
                    print(error.localizedDescription)
                }
            })
        } label: {
            Text("Save")
                .foregroundColor(viewModel.shouldGoNext ? Color.subElement : Color.gray)
        }
            .disabled(!viewModel.shouldGoNext)
        )
        .sheet(isPresented: $showSheet) {
            StatSheetView(viewModel: viewModel, statType: viewModel.sheetType)
        }
        .onChange(of: showSheet) { newValue in
            viewModel.showAddStatsSheet = newValue
        }
    }
}

struct StatsRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        StatsRecorderView(viewModel: GameStatsViewModel())
    }
}
