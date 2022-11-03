//
//  OpponentsViewModel.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI
import Combine

class OpponentsViewModel: ObservableObject {
    @Published var firstTeam: Team?
    @Published var secondTeam: Team?
    @Published var isRequestFailed = false
    private var cancellable: AnyCancellable?
    
    func loadOpponents(matchId: Int) {
        cancellable = PandaScoreAPI.shared.fetchMatchOpponents(matchId: matchId)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.isRequestFailed = true
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { match in
                self.firstTeam = match.opponents.first
                self.secondTeam = match.opponents.last
            }
    }
}
