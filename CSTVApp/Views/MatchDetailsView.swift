//
//  MatchDetailsView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchDetailsView: View {
    let match: Match
    private var bgColor = Color(red: 0.086, green: 0.086, blue: 0.129) // #161621
    
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
            
            Text("teste")
                .foregroundColor(.white)
        }
        .navigationTitle("\(match.league.name.orEmpty) \(match.serie.name.orEmpty)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailsView(match: Match(id: 1, name: "", scheduledAt: "", opponents: [], league: .init(name: "", imageUrl: ""), serie: .init(name: "")))
    }
}
