//
//  FinalGameStatView.swift
//  BoxScore
//
//  Created by TomF on 19/01/2023.
//

import SwiftUI

struct FinalGameStatView: View {
    
    @StateObject public var viewModel: GameStatsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FinalGameStatView_Previews: PreviewProvider {
    static var previews: some View {
        FinalGameStatView(viewModel: GameStatsViewModel())
    }
}
