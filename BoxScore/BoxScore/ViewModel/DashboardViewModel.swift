//
//  DashboardViewModel.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import Foundation

public class DashboardViewModel: ObservableObject {
    public var menuElements: [MenuElements] = [MenuElements(id: UUID().uuidString, title: "Record a new game", image: "match", imageOffset: 40),
                                               MenuElements(id: UUID().uuidString, title: "See all games", image: "game", imageOffset: -57),
                                               MenuElements(id: UUID().uuidString, title: "Manage teams", image: "team", imageOffset: 0)]
}

//extension DashboardViewModel {
public struct MenuElements: Identifiable {
        public var id: String
        public var title: String
        public var image: String
        public var imageOffset: Double
    }
//}
