//
//  NoDataView.swift
//  BoxScore
//
//  Created by TomF on 01/02/2023.
//

import SwiftUI
import Foundation

struct NoDataView: View {
    
    public var image: String
    public var text: String
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Image(systemName: image)
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(Color.text)
                
                Text(text)
                    .foregroundColor(Color.text)
                    .font(.system(size: 20, weight: .semibold))
            }
            Spacer()
        }
        
        .padding(.horizontal)
        .frame(height: 150)
        .background(Color.subElement)
        .cornerRadius(8)
    }
}

struct NoDataView_Previews: PreviewProvider {
    static var previews: some View {
        NoDataView(image: "info.circle.fill", text: "No game recorded yet")
    }
}
