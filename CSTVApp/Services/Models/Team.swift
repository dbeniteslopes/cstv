//
//  Team.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import Foundation

struct Team: Decodable, Identifiable {
    let id: Int
    let players: [Player]
}
