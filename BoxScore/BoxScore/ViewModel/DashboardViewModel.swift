//
//  DashboardViewModel.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import Foundation

public class DashboardViewModel: ObservableObject {
    public var menuElements: [MenuElements] = [MenuElements(id: UUID().uuidString, title: "Record a new game", image: "match", imageOffset: 40, linkValue: .newGame),
                                               MenuElements(id: UUID().uuidString, title: "See all games", image: "game", imageOffset: -57, linkValue: .allGames),
                                               MenuElements(id: UUID().uuidString, title: "Manage teams", image: "team", imageOffset: 0, linkValue: .teams)]
}


public struct MenuElements: Identifiable, Hashable {
    public enum ElementsValue {
        case newGame
        case allGames
        case teams
    }
    
    public var id: String
    public var title: String
    public var image: String
    public var imageOffset: Double
    public var linkValue: ElementsValue
}
