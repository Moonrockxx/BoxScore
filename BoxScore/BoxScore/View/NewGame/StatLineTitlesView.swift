//
//  StatLineTitlesView.swift
//  BoxScore
//
//  Created by TomF on 24/01/2023.
//

import SwiftUI

struct StatLineTitlesView: View {
    
    var body: some View {
        HStack {
            FirstStatLineTitlesGroup()
            SecondStatLineTitlesGroup()
            ThirdStatLineTitlesGroup()
            LastStatLineTitlesGroup()
        }
        .font(.system(size: 16, weight: .bold))
    }
}

struct FirstStatLineTitlesGroup: View {
    
    var body: some View {
        Group {
            Text("Pts")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("Reb D")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("Reb O")
                .frame(width: 75)
            
            Spacer(minLength: 25)
        }
    }
}

struct SecondStatLineTitlesGroup: View {
    
    var body: some View {
        Group {
            Text("Tot")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("Ast")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("Blk")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("Int")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("TO")
                .frame(width: 75)
            
            Spacer(minLength: 25)
        }
    }
}

struct ThirdStatLineTitlesGroup: View {
    
    var body: some View {
        Group {
            Text("PF")
                .frame(width: 75)
            
            Spacer(minLength: 25)
            
            Text("FT A/M")
                .frame(width: 100)
            
            Spacer(minLength: 25)
            
            Text("FT %")
                .frame(width: 100)
            
            Spacer(minLength: 25)
            
            Text("2pts A/M")
                .frame(width: 100)
            
            Spacer(minLength: 25)
        }
    }
}

struct LastStatLineTitlesGroup: View {
    var body: some View {
        Group {
            Text("2pts %")
                .frame(width: 100)
            
            Spacer(minLength: 25)
            
            Text("3pts A/M")
                .frame(width: 100)
            
            Spacer(minLength: 25)
            
            Text("3pts %")
                .frame(width: 100)
        }
    }
}

struct NumberAndNameTitlesGroupView: View {
    var body: some View {
        HStack {
            Text("N°")
                .frame(width: 30)
            
            Spacer(minLength: 10)
            
            Text("Name")
                .frame(width: 150)
            
            Spacer(minLength: 25)
        }
    }
}

struct StatLineTitlesView_Previews: PreviewProvider {
    static var previews: some View {
        StatLineTitlesView()
    }
}
