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
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.gameSamples, id: \.id) { game in
                            GameRowView(item: game)
                        }
                    }
                    
                }
                .padding(.top, 50)
                .padding(.horizontal)
                
                
                NavigationLink("", isActive: $goToSettings) {
                    SettingsView()
                }
                .hidden()
                
//                Spacer()
            }
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
        .background(Color.white)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
