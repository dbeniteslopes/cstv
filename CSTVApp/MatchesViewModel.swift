//
//  MatchesViewModel.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import SwiftUI
import Combine

class MatchesViewModel: ObservableObject {
    @Published var matches: [Match] = []
    @Published var isRequestFailed = false
    private let pageLimit = 10
    private var currentPage: Int = 1
    private var cancellable: AnyCancellable?
    
    func loadMatches() {
        cancellable = PandaScoreAPI.shared.fetchMatches(perPage: pageLimit, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.isRequestFailed = true
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { games in
                self.matches.append(contentsOf: games)
                self.currentPage += 1
            }
    }
}
