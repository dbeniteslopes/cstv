//
//  OpponentsViewModel.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI
import Combine

class OpponentsViewModel: ObservableObject {
    @Published var firstTeamPlayers: [Player] = []
    @Published var secondTeamPlayers: [Player] = []
    private var cancellable: AnyCancellable?
    
    func loadOpponents(matchId: Int) {
        cancellable = PandaScoreAPI.shared.fetchMatchOpponents(matchId: matchId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { match in
                self.firstTeamPlayers = match.opponents.first?.players ?? []
                self.secondTeamPlayers = match.opponents.last?.players ?? []
            }
    }
}
