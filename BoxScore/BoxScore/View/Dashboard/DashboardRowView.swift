//
//  DashboardRowView.swift
//  BoxScore
//
//  Created by TomF on 06/12/2022.
//

import SwiftUI

struct DashboardRowView: View {
    
    public var item: MenuElements
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                
                Text(item.title)
                    .foregroundColor(Color.text)
                    .padding(.bottom)
            }
            .padding(.leading, 20)
            
            Spacer()
            
            Image(systemName: "chevron.forward.circle")
                .renderingMode(.template)
                .foregroundColor(Color.text)
                .padding(.trailing, 5)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
        )
        .background(
            Image(item.image)
                .resizable()
                .saturation(0.2)
                .aspectRatio(contentMode: .fill)
                .offset(y: item.imageOffset)
                .frame(height: 100)
                .clipped()
        )
        .cornerRadius(8)
        .frame(height: 100)
        .padding(.horizontal)
    }
}

struct DashboardRowView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardRowView(item: MenuElements(id: UUID().uuidString, title: "Record a new game", image: "team", imageOffset: 0, linkValue: .newGame))
    }
}
