//
//  SettingsClubNameView.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import SwiftUI

struct SettingsClubNameView: View {
    
    @AppStorage("clubName") private var clubName: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your club name", text: $clubName)
            } header: {
                Text("Club name")
            }
        }
        .navigationTitle("Club informations")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SettingsClubNameView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsClubNameView()
    }
}
