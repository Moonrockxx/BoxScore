//
//  CoreDataManager.CDErrors+Extensions.swift
//  BoxScore
//
//  Created by TomF on 27/01/2023.
//

import Foundation
import CoreData

extension CoreDataManager.CDErrors {
    var title: String {
        switch self {
        case .noData:
            return "No datas found in your favorites"
        case .saveError:
            return "An error occured on save"
        }
    }
}
