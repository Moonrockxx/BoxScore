//
//  FinalGameStatView.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import SwiftUI
import Tabler

struct FinalGameStatView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    
    var body: some View {
        VStack {
            Text("Final view")
        }
        .navigationBarItems(trailing: Button(action: {
            viewModel.backToDashboard()
        }, label: {
            Text("Quit")
        }))
    }
}

struct FinalGameStatView_Previews: PreviewProvider {
    static var previews: some View {
        FinalGameStatView(viewModel: GameStatsViewModel())
    }
}
