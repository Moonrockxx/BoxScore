//
//  DashboardView.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import SwiftUI

struct DashboardView: View {
    @StateObject public var viewModel: DashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.menuElements) { item in
                        NavigationLink {
                            switch item.linkValue {
                            case .newGame:
                                NewGameTeamSelectionView()
                            case .allGames:
                                Text("All games")
                            case .teams:
                                AllTeamsView()
                            }
                        } label: {
                            DashboardRowView(item: item)
                        }
                    }
                }
                .padding(.top, 25)
                
                Spacer()
            }
            .navigationTitle("BoxScore")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button {
                    // open settings
                } label: {
                    Image(systemName: "gearshape.circle")
                        .tint(Color.subElement)
                }
            )
        }
        .background(Color.white)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
