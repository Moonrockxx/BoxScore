//
//  SettingsViewModel.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import Foundation

public class SettingsViewModel: ObservableObject {
    @Published public var canSaveName: Bool = false
    @Published public var clubName: String = "" {
        didSet {
            self.canSaveName = clubName.count >= 3
        }
    }
    
    public func saveClubName() {
        UserDefaults.standard.set(self.clubName, forKey: "clubName")
    }
}
