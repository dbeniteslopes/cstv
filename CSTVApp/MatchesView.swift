//
//  MatchesView.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI

struct MatchesView: View {
    @ObservedObject private var viewModel = MatchesViewModel()
    
    private var bgColor = Color(red: 0.086, green: 0.086, blue: 0.129) // #161621
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = attributes
        navBarAppearance.titleTextAttributes = attributes
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                bgColor.ignoresSafeArea()
                
                VStack {
                    ForEach(viewModel.matches, id: \.id) {
                        Text($0.name).foregroundColor(.white)
                    }
                }
                .onAppear(perform: viewModel.loadMatches)
            }
            .navigationTitle("Partidas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}
