//
//  PandaScoreAPI.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import Foundation
import Combine

class PandaScoreAPI {
    static let shared = PandaScoreAPI()
    
    func fetchMatches(perPage: Int = 30, page: Int) -> AnyPublisher<[Match], Error> {
        let url = "https://api.pandascore.co/matches"
        var components = URLComponents(string: url)!
        components.queryItems = [
            URLQueryItem(name: "token", value: "x_M7yIBpSoor4Y05LFLISHLXqxpxK3xKankCv4878AF-zPaSNWw"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(perPage)")
        ]
        
        let request = URLRequest(url: components.url!, timeoutInterval: 5)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Match].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
