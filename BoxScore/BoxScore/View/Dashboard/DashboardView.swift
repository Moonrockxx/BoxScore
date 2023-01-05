//
//  DashboardView.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject public var viewModel: DashboardViewModel = DashboardViewModel()
    @State private var goToSettings: Bool = false
    
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
                                    .environmentObject(controller)
                                    .environment(\.managedObjectContext, controller.container.viewContext)
                            }
                        } label: {
                            DashboardRowView(item: item)
                        }
                    }
                }
                .padding(.top, 25)
                
                NavigationLink("", isActive: $goToSettings) {
                    SettingsView()
                }
                .hidden()
                
                Spacer()
            }
            .navigationTitle("BoxScore")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button {
                self.goToSettings = true
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
