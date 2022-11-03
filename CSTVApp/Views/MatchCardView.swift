//
//  MatchCardView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchCardView: View {
    let match: Match
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                MatchTimeView(date: match.scheduledAt.toDate())
            }
            
            TeamsContainerView(match.opponents[0], match.opponents[1])
            
            divider
            
            cardFooter
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.153, green: 0.149, blue: 0.224, opacity: 1))
        )
    }
    
    var divider: some View {
        Rectangle()
            .fill(.white.opacity(0.2))
            .frame(height: 1)
    }
    
    var cardFooter: some View {
        HStack {
            if let url = match.league.imageUrl, url != "" {
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable()
                } placeholder: {
                    placeholder
                }
                .frame(maxWidth: 16, maxHeight: 16)
            } else {
                placeholder
            }
            
            Text("\(match.league.name.orEmpty) \(match.serie.name.orEmpty)")
                .font(.custom("Roboto", size: 8))
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
    
    var placeholder: some View {
        Circle()
            .fill(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 1))
            .frame(width: 16, height: 16)
    }
}
