//
//  FinalGameStatView.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import SwiftUI
import Tabler

struct FinalGameStatView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    @State private var showYourTeamStats: Bool = false
    @State private var showOppositeTeamStats: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Section {
                HStack {
                    Button {
                        self.showYourTeamStats.toggle()
                        self.showOppositeTeamStats = false
                    } label: {
                        Text(viewModel.game?.yourTeam?.clubName ?? "SO Carcassonne")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 150)
                    .padding()
                    .background(showYourTeamStats ? Color.subElement : Color.gray)
                    .cornerRadius(8)
                    

                    Button {
                        self.showAlert = true
                    } label: {
                        Text(viewModel.game?.oppositeTeam?.clubName ?? "SO Coursan")
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 150)
                    .padding()
                    .background(showOppositeTeamStats ? Color.subElement : Color.gray)
                    .cornerRadius(8)
                    
                }
            } header: {
                Text("Stats for")
                    .font(.system(size: 18, weight: .bold))
            }
            
            if !showYourTeamStats && !showOppositeTeamStats {
                Text("General stats here")
                    .padding(.top, 30)
            }
            
            if showYourTeamStats {
                ScrollView(.horizontal, showsIndicators: false) {
                    StatLineTitlesView()
                    
                    Spacer()
                        .frame(height: 5)
                    
                    ForEach(viewModel.game?.yourTeam?.players ?? [], id: \.id) { item in
                        StatLineView(playerItem: item)
                            .padding(.vertical, 5)
                    }
                }
                .padding(.vertical, 30)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .alert("No stats for \(viewModel.game?.oppositeTeam?.clubName ?? "") players",
               isPresented: $showAlert,
               actions: {
            Button("OK", role: .cancel) { }
        })
        .navigationBarItems(trailing: Button(action: {
            viewModel.backToDashboard()
        }, label: {
            Text("Quit")
        }))
    }
}

struct FinalGameStatView_Previews: PreviewProvider {
    static var previews: some View {
        FinalGameStatView(viewModel: GameStatsViewModel())
    }
}
