//
//  MatchDetailsView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchDetailsView: View {
    @ObservedObject private var viewModel = OpponentsViewModel()
    
    private let match: Match
    private let bgColor = Color(red: 0.086, green: 0.086, blue: 0.129) // #161621
    
    init(match: Match) {
        self.match = match
        let navBarAppearance = UINavigationBar.appearance()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = attributes
        navBarAppearance.titleTextAttributes = attributes
    }
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            
            VStack {
                TeamsContainerView(match.opponents[0], match.opponents[1])
                
                matchTime
                
                HStack {
                    VStack {
                        ForEach(viewModel.firstTeamPlayers, id: \.id) { p in
                            Text(p.nickname)
                        }
                    }
                    
                    VStack {
                        ForEach(viewModel.secondTeamPlayers, id: \.id) { p in
                            Text(p.nickname)
                        }
                    }
                }
                
                Spacer()
                    .onAppear(perform: loadOpponents)
            }
        }
        .navigationTitle("\(match.league.name.orEmpty) \(match.serie.name.orEmpty)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var matchTime: some View {
        Text(match.scheduledAt.toDate().relativeDescription)
            .foregroundColor(.white)
            .font(.custom("Roboto", size: 12))
            .padding(.top, 20)
            .padding(.bottom, 24)
    }
    
    private func loadOpponents() {
        viewModel.loadOpponents(matchId: match.id)
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(match: Match(id: 1, name: "", scheduledAt: "", opponents: [], league: .init(name: "", imageUrl: ""), serie: .init(name: "")))
    }
}
