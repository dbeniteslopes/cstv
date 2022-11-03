//
//  Team.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import Foundation

struct MatchOpponents: Decodable {
    let opponents: [Team]
}

struct Team: Decodable, Identifiable {
    let id: Int
    let players: [Player]
}

struct Player: Decodable, Identifiable {
    let id: Int
    let nickname: String
    let firstName: String?
    let lastName: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname = "name"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
