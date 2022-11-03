//
//  Opponent.swift
//  CSTVApp
//
//  Created by Diego Benites Lopes on 02/11/22.
//

import Foundation

struct Opponent: Decodable, Identifiable {
    private let opponent: InnerOpponent
    
    var id: Int {
        opponent.id
    }
    
    var imageUrl: String? {
        opponent.imageUrl
    }
    
    var name: String {
        opponent.name
    }
    
    struct InnerOpponent: Decodable, Identifiable {
        let id: Int
        let imageUrl: String?
        let name: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case imageUrl = "image_url"
            case name
        }
    }
}
