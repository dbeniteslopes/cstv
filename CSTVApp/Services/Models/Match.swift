//
//  Match.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import Foundation

struct Match: Decodable, Identifiable {
    let id: Int
    let name: String
    let scheduledAt: String
    let opponents: [Opponent]
    let league: League
    let serie: Serie
    
    enum CodingKeys: String, CodingKey {
        case id, name, opponents, league, serie
        case scheduledAt = "scheduled_at"
    }
}
