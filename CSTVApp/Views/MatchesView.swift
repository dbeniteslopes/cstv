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
                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(viewModel.matches, id: \.id) { m in
                            NavigationLink {
                                MatchDetailsView(match: m)
                            } label: {
                                MatchCardView(match: m)
                                    .padding([.horizontal, .top], 24)
                            }
                        }
                        
                        ProgressView()
                            .scaleEffect(2)
                            .onAppear(perform: viewModel.loadMatches)
                            .padding(.top, 24)
                    }
                }
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
