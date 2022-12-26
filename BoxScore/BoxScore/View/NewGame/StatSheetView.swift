//
//  StatSheetView.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import SwiftUI

struct StatSheetView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    @AppStorage("clubName") private var clubName: String = ""
    @State private var showPlayersList: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Which team ?")
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button {
                        viewModel.addForWhichTeam = viewModel.game?.homeTeam
                        self.showPlayersList = true
                    } label: {
                        Text(viewModel.game?.homeTeam?.clubName ?? "")
                            .foregroundColor(Color.text)
                    }
                    .frame(height: 75)
                    .padding(.horizontal)
                    .background(Color.element)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    
                    Spacer()
                    
                    Button {
                        viewModel.addForWhichTeam = viewModel.game?.awayTeam
                        self.showPlayersList = true
                    } label: {
                        Text(viewModel.game?.awayTeam?.clubName ?? "")
                            .foregroundColor(Color.text)
                    }
                    .frame(height: 75)
                    .padding(.horizontal)
                    .background(Color.element)
                    .clipShape(RoundedRectangle(cornerRadius: 8.0))
                    Spacer()
                }
                
            }
            .padding()
        }
    }
}

struct StatSheetView_Previews: PreviewProvider {
    static var previews: some View {
        StatSheetView(viewModel: GameStatsViewModel())
    }
}
