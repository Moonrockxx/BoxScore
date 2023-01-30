//
//  GameRecorderRootView.swift
//  BoxScore
//
//  Created by TomF on 24/01/2023.
//

import SwiftUI

struct GameRecorderRootView: View {
    
    @StateObject public var viewModel: GameStatsViewModel = GameStatsViewModel()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            viewModel.view(type: viewModel.flowType, viewModel: viewModel)
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
