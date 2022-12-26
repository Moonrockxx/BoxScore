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
                        Text("88")
                            .padding(.horizontal, 16)
                            .background(Color.subElement)
                            .clipShape(Capsule())
                    }
                    
                    Text("\(viewModel.isHomeGame ? "VS" : "@")")
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text(viewModel.oppositeTeamName)
                        Text("57")
                            .padding(.horizontal, 16)
                            .background(Color.subElement)
                            .clipShape(Capsule())
                    }
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
                            self.showSheet = true
                        })
                    }
                    Spacer()
                }
                .frame(height: 75)
                
                HStack(spacing: 30) {
                    Spacer()
                    ForEach(viewModel.secondRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            self.showSheet = true
                        })
                    }
                    Spacer()
                }
                .frame(height: 75)
                
                HStack(spacing: 30) {
                    Spacer()
                    ForEach(viewModel.thirdRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            self.showSheet = true
                        })
                    }
                    Spacer()
                }
                .frame(height: 75)
            }
            .padding()
            
            Spacer()
            
        }
        .sheet(isPresented: $showSheet) {
            StatSheetView(viewModel: viewModel)
        }
    }
}

struct StatsRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        StatsRecorderView(viewModel: GameStatsViewModel())
    }
}
