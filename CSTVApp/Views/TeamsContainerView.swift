//
//  TeamsContainerView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct TeamsContainerView: View {
    private let firstTeam: Opponent
    private let secondTeam: Opponent
    
    init(_ firstTeam: Opponent, _ secondTeam: Opponent) {
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Spacer()
            TeamView(team: firstTeam)
            
            Text("vs")
                .foregroundColor(.white.opacity(0.5))
                .font(.custom("Roboto", size: 12))
                .padding(.horizontal, 20)
            
            TeamView(team: secondTeam)
            Spacer()
        }
        .padding(.vertical, 18.5)
    }
}
