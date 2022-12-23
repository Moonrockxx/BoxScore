//
//  NavigationButton.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import Foundation
import SwiftUI

public struct NavigationButton<Destination, Label>: View where Destination: View, Label: View {
    public var destination: () -> Destination
    public var label: () -> Label
    public var action: (() -> ())?
    @State var isActive: Bool = false
    
    public var body: some View {
        ZStack {
            NavigationLink<EmptyView, Destination>(isActive: $isActive,
                                                   destination: { destination() },
                                                   label: {})
            .hidden()
            Button {
                isActive = true
                action?()
            } label: {
                label()
            }
        }
    }
    
    public init(@ViewBuilder destination: @escaping () -> Destination, @ViewBuilder label: @escaping () -> Label, action: (() -> ())? = nil) {
        self.destination = destination
        self.label =  label
        self.action = action
    }
}
