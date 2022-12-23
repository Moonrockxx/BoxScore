//
//  StatsRecorderView.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import SwiftUI

struct StatsRecorderView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    @AppStorage("clubName") var clubName = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 15) {
                Text("U17 - M")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.subElement)
                    .clipShape(Capsule())
                
                HStack(alignment: .center) {
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        Text(clubName)
                        Text("88")
                            .padding(.horizontal, 16)
                            .background(Color.subElement)
                            .clipShape(Capsule())
                    }
                    Spacer()
                    VStack(alignment: .center, spacing: 10) {
                        Text("SO Coursan")
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
                            
                        })
                    }
                    Spacer()
                }
                .frame(height: 75)
                
                HStack(spacing: 30) {
                    Spacer()
                    ForEach(viewModel.secondRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            
                        })
                    }
                    Spacer()
                }
                .frame(height: 75)
                
                HStack(spacing: 30) {
                    Spacer()
                    ForEach(viewModel.thirdRow, id: \.self) { item in
                        AddStatButtonView(item: item, closure: {
                            
                        })
                    }
                    Spacer()
                }
                .frame(height: 75)
            }
            .padding()
            
            Spacer()
            
        }
        
    }
}

struct StatsRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        StatsRecorderView(viewModel: GameStatsViewModel())
    }
}
