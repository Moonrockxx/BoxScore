//
//  TeamRowView.swift
//  BoxScore
//
//  Created by TomF on 13/12/2022.
//

import SwiftUI

struct TeamRowView: View {
    
    public var item: Team
    public var image: String {
        item.isMenTeam ? "menTeam" : "girlTeam"
    }
    public var offsetForImage: Double {
        item.isMenTeam ? 40 : 0
    }
    
    var body: some View {
        HStack {
            VStack {
                Spacer()
                
                Text(item.name ?? "")
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
            Image(item.isMenTeam ? "menTeam" : "girlTeam")
                .resizable()
                .saturation(0.2)
                .aspectRatio(contentMode: .fill)
                .offset(y: 40)
                .frame(height: 100)
                .clipped()
        )
        
        .frame(height: 100)
        .cornerRadius(8)
//        .padding(.horizontal)
    }
}

//struct TeamRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamRowView(item: Team(categorie: .s ,score: 0, isMenTeam: true, isMultipleTeams: false))
//    }
//}
