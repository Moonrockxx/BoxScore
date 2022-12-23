//
//  StatsRecorderView.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import SwiftUI

struct StatsRecorderView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    
    var body: some View {
        VStack {
            Section {
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
            } header: {
                Text("Your team")
                
            }
            
            VStack(spacing: 15) {
                Text("U17 - M")
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.subElement)
                    .clipShape(Capsule())
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("SO Carcassonne")
                    Text("88 - 57")
                        .padding(.horizontal, 16)
                        .background(Color.subElement)
                        .clipShape(Capsule())
                    Text("SO Coursan")
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
            
            Section {
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
            } footer: {
                Text("Opposite team")
            }
        }
        
    }
}

struct StatsRecorderView_Previews: PreviewProvider {
    static var previews: some View {
        StatsRecorderView(viewModel: GameStatsViewModel())
    }
}
