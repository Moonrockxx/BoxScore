//
//  PlayerRowSelectableView.swift
//  BoxScore
//
//  Created by TomF on 22/12/2022.
//

import SwiftUI

struct PlayerRowSelectableView: View {
    
    var isInGame: Bool
    var item: Player
    var closure: () -> ()
    
    @State private var isChecked: Bool = false
    
    var body: some View {
        Button {
            closure()
            self.isChecked.toggle()
        } label: {
            HStack {
                if !isInGame {
                    Image(systemName: isChecked ? "checkmark.circle" : "circle")
                        .renderingMode(.template)
                        .foregroundColor(isChecked ? Color.subElement : Color.gray)
                }
                Text(item.lastName + " " + item.firstName)
                
                Spacer()
                
                Text(item.number)
            }
            .foregroundColor(Color.black)
        }
    }
    
}
