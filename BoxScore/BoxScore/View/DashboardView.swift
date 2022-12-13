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
            VStack {
                VStack(spacing: 10) {
                    ForEach(viewModel.menuElements) { item in
                        DashboardRowView(item: item)
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .background(Color.background)
            .navigationTitle("BoxScore")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // open settings
                    } label: {
                        Image(systemName: "gearshape.circle")
                            .tint(Color.subElement)
                    }
                }
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
