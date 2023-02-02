//
//  DashboardView.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import SwiftUI

struct DashboardView: View {
    @StateObject public var viewModel: DashboardViewModel = DashboardViewModel()
    @State private var goToSettings: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ForEach(viewModel.menuElements) { item in
                    NavigationLink {
                        switch item.linkValue {
                        case .newGame:
                            GameRecorderRootView()
                        case .allGames:
                            AllGamesView()
                        case .teams:
                            AllTeamsView()
                        }
                    } label: {
                        DashboardRowView(item: item)
                    }
                }
                
                VStack {
                    HStack {
                        Text("Recent games")
                            .font(.system(size: 20, weight: .bold))
                        
                        Spacer()
                    }
                    
                    if viewModel.fetchedGames.isEmpty {
                        NoDataView(image: "info.circle",
                                   text: "No game recorded yet")
                    } else {
                        List {
                            ForEach(viewModel.fetchedGames.reversed(), id: \.id) { game in
                                ZStack {
                                    NavigationLink {
                                        FinalGameStatView(viewModel: GameStatsViewModel(), isFromRecorderFlow: false, item: game)
                                    } label: {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    
                                    GameRowView(item: game)
                                }
                                .listRowInsets(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                                .listRowSeparator(.hidden)
                            }
                        }
                        .listStyle(InsetListStyle())
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal)
                
                Spacer()
                
                NavigationLink("", isActive: $goToSettings) {
                    SettingsView()
                }
                .hidden()
            }
            .onAppear(perform: {
                viewModel.fetchGames()
            })
            .edgesIgnoringSafeArea(.bottom)
            .padding(.top, 25)
            .navigationTitle("BoxScore")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button {
                self.goToSettings = true
            } label: {
                Image(systemName: "gearshape.circle")
                    .tint(Color.subElement)
            })
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
