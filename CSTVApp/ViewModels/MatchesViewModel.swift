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
    private let pageLimit = 30
    private var currentPage: Int = 1
    private var cancellable: AnyCancellable?
    
    func loadMatches() {
        cancellable = PandaScoreAPI.shared.fetchMatches(perPage: pageLimit, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("finished")
                }
            } receiveValue: { matches in
                let filtered = matches.filter { m in
                    m.opponents.count == 2
                }
                self.matches.append(contentsOf: filtered)
                self.matches.sort { (m1, m2) in
                    m1.scheduledAt < m2.scheduledAt
                }
                self.currentPage += 1
            }
    }
}
