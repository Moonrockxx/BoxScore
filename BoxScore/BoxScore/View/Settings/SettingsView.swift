//
//  SettingsView.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section {
                NavigationButton {
                    SettingsClubNameView()
                } label: {
                    HStack {
                        Text("Club informations")
                            .foregroundColor(Color.black)
                        Spacer()
                        Image(systemName: "chevron.right.circle")
                            .font(.system(size: 17.0, weight: .semibold))
                            .foregroundColor(Color.gray)
                        
                    }
                    .contentShape(Rectangle())
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
