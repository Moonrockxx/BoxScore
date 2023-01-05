//
//  BoxScoreApp.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import SwiftUI

@main
struct BoxScoreApp: App {
    
    @StateObject private var dataController: DataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .background(Color.background)
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
