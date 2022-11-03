//
//  Player.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 03/11/22.
//

import Foundation

struct Player: Decodable, Identifiable {
    let id: Int
    let nickname: String
    let firstName: String?
    let lastName: String?
    let imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case nickname = "name"
        case firstName = "first_name"
        case lastName = "last_name"
        case imageUrl = "image_url"
    }
}
