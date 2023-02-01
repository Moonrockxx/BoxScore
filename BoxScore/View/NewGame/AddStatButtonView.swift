//
//  AddStatButtonView.swift
//  BoxScore
//
//  Created by TomF on 23/12/2022.
//

import SwiftUI

struct AddStatButtonView: View {
    
    var item: RecordableStats
    var closure: () -> ()
    
    var body: some View {
        Button {
            closure()
        } label: {
            Text(item.title)
                .foregroundColor(Color.text)
        }
        .frame(width: 75, height: 75)
        .background(Color.element)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

struct AddStatButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddStatButtonView(item: .threePoints, closure: {
            
        })
    }
}
