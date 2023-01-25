//
//  View+Extensions.swift
//  BoxScore
//
//  Created by TomF on 25/01/2023.
//

import Foundation
import SwiftUI

extension View {
    func forTrailingZero(temp: Double) -> String {
        let tempVar = String(format: "%g", temp)
        return tempVar
    }
}
