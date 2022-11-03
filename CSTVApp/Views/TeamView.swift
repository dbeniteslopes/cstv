//
//  TeamView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct TeamView: View {
    let team: Opponent
    
    var body: some View {
        VStack(spacing: 10) {
            if let url = team.imageUrl, url != "" {
                AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                } placeholder: {
                    placeholder
                }
            } else {
                placeholder
            }
            
            Text(team.name)
                .foregroundColor(.white)
                .font(.custom("Roboto", size: 10))
        }
    }
    
    var placeholder: some View {
        Circle()
            .fill(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 1))
            .frame(width: 60, height: 60)
    }
}
