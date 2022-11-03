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
                            MatchCard(match: m)
                                .padding([.horizontal, .top], 24)
                        }
                        
                        ProgressView()
                            .onAppear(perform: viewModel.loadMatches)
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

struct MatchCard: View {
    let match: Match
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                MatchTimeView(date: match.scheduledAt.toDate())
            }
            
            HStack(spacing: 12) {
                TeamView(team: match.opponents[0])
                
                Text("vs")
                    .foregroundColor(.white)
                
                TeamView(team: match.opponents[1])
            }
            .padding(.vertical, 18.5)
            
            Rectangle()
                .fill(.white.opacity(0.2))
                .frame(height: 1)
            
            HStack {
                Circle()
                    .fill(Color(red: 0.769, green: 0.769, blue: 0.769, opacity: 1))
                    .frame(width: 16, height: 16)
                Text("\(match.league.name.orEmpty) \(match.serie.name.orEmpty)")
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(red: 0.153, green: 0.149, blue: 0.224, opacity: 1))
        )
    }
}

struct CustomRoundedRectangle: Shape {
    
    var corners: UIRectCorner = .allCorners
    var cornerRadius: CGFloat = .infinity
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        return Path(path.cgPath)
    }
}
