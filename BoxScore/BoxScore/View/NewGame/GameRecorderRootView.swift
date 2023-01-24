//
//  GameRecorderRootView.swift
//  BoxScore
//
//  Created by TomF on 24/01/2023.
//

import SwiftUI

struct GameRecorderRootView: View {
    
    @ObservedObject public var viewModel: GameStatsViewModel = GameStatsViewModel()
    
    @EnvironmentObject var controller: DataController
    @Environment(\.managedObjectContext) private var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            viewModel.view(type: viewModel.flowType, viewModel: viewModel)
                .environmentObject(controller)
                .environment(\.managedObjectContext, controller.container.viewContext)
                .onChange(of: viewModel.dismissRecorderFlow) { _ in
                    presentationMode.wrappedValue.dismiss()
                }
        }
        .navigationTitle(viewModel.flowType.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GameRecorderRootView_Previews: PreviewProvider {
    static var previews: some View {
        GameRecorderRootView()
    }
}
