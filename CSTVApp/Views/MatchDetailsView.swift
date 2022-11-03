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
                
                HStack(spacing: 16) {
                    VStack(spacing: 16) {
                        ForEach(viewModel.firstTeamPlayers, id: \.id) { player in
                            HStack(alignment: .top, spacing: 16) {
                                Spacer()
                                VStack(alignment: .trailing) {
                                    Text(player.nickname)
                                        .foregroundColor(.white)
                                        .font(.custom("Roboto", size: 14))
                                        .lineLimit(1)
                                        .padding(.top, 16)
                                    
                                    Text("\(player.firstName.orEmpty) \(player.lastName.orEmpty)")
                                        .foregroundColor(Color(red: 0.424, green: 0.42, blue: 0.494, opacity: 1))
                                        .font(.custom("Roboto", size: 12))
                                        .lineLimit(1)
                                        .padding(.bottom, 8)
                                }
                                
                                if let url = player.imageUrl, url != "" {
                                    AsyncImage(url: URL(string: url)) { image in
                                        image
                                            .resizable()
                                            .frame(width: 48, height: 48)
                                            .offset(y: -2.5)
                                            .padding(.trailing, 12)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } placeholder: {
                                        placeholder
                                    }
                                } else {
                                    placeholder
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .fill(Color(red: 0.153, green: 0.149, blue: 0.224, opacity: 1))
                                    .cornerRadius(radius: 8, corners: [.topRight, .bottomRight])
                            )
                        }
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 16) {
                        ForEach(viewModel.secondTeamPlayers, id: \.id) { player in
                            HStack(alignment: .top, spacing: 16) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 1))
                                    .frame(width: 48, height: 48)
                                    .offset(y: -2.5)
                                    .padding(.leading, 12)
                                
                                VStack(alignment: .leading) {
                                    Text(player.nickname)
                                        .foregroundColor(.white)
                                        .font(.custom("Roboto", size: 14))
                                        .lineLimit(1)
                                        .padding(.top, 16)
                                    
                                    Text("\(player.firstName.orEmpty) \(player.lastName.orEmpty)")
                                        .foregroundColor(Color(red: 0.424, green: 0.42, blue: 0.494, opacity: 1))
                                        .font(.custom("Roboto", size: 12))
                                        .lineLimit(1)
                                        .padding(.bottom, 8)
                                }
                                
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .background(
                                Rectangle()
                                    .fill(Color(red: 0.153, green: 0.149, blue: 0.224, opacity: 1))
                                    .cornerRadius(radius: 8, corners: [.topLeft, .bottomLeft])
                            )
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
    
    var placeholder: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 1))
            .frame(width: 48, height: 48)
            .offset(y: -2.5)
            .padding(.trailing, 12)
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
