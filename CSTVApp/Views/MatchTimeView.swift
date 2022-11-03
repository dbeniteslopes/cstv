//
//  MatchTimeView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchTimeView: View {
    let date: Date?
    
    private var bgColor: Color {
        guard let date = date else {
            return .gray
        }
        
        let red = Color(red: 0.957, green: 0.165, blue: 0.208, opacity: 1)
        let gray = Color(red: 0.979, green: 0.979, blue: 0.979, opacity: 0.2)
        
        return Date() > date ? red : gray
    }
    
    var body: some View {
        Text(date.relativeDescription)
            .foregroundColor(.white)
            .font(.custom("Roboto", size: 8))
            .frame(height: 25)
            .padding(.horizontal, 8)
            .background(
                Rectangle()
                    .fill(bgColor)
                    .cornerRadius(radius: 16, corners: [.topRight, .bottomLeft])
            )
    }
}
