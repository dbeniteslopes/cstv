//
//  MatchDetailsView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchDetailsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
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
                
                ProgressView()
                    .scaleEffect(2)
                    .opacity(viewModel.firstTeamPlayers.isEmpty ? 1 : 0)
                
                HStack(spacing: 16) {
                    VStack(spacing: 16) {
                        ForEach(viewModel.firstTeamPlayers, id: \.id) { player in
                            PlayerView(player: player, columnSide: .left)
                        }
                        Spacer()
                    }
                    
                    VStack(spacing: 16) {
                        ForEach(viewModel.secondTeamPlayers, id: \.id) { player in
                            PlayerView(player: player, columnSide: .right)
                        }
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .onAppear(perform: loadOpponents)
        }
        .navigationTitle("\(match.league.name.orEmpty) \(match.serie.name.orEmpty)")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: { self.mode.wrappedValue.dismiss() }) {
                    Image("ic-arrow-left")
                }
            }
        }
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
