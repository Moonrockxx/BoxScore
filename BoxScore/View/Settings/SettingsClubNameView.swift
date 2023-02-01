//
//  SettingsClubNameView.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import SwiftUI

struct SettingsClubNameView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject public var viewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Enter your club name", text: $viewModel.clubName)
            } header: {
                Text("Club name")
            }
        }
        .navigationTitle("Club informations")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarItems(trailing:
                                Button(action: {
            viewModel.saveClubName()
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Save")
                .foregroundColor(viewModel.canSaveName ? Color.subElement : Color.gray)
        })
                                    .disabled(!viewModel.canSaveName)
        )
    }
}

struct SettingsClubNameView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsClubNameView(viewModel: SettingsViewModel())
    }
}
