//
//  Pokemon.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

class Pokemon: NSObject, Codable {
    
    let id: Int
    let name: String
    let sprites: PokemonSprites
    let types: [PokemonType]
    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case sprites
//        case types
//
//    }
    
    init(id: Int, name: String, sprites: PokemonSprites, types: [PokemonType]) {
        self.id = id
        self.name = name
        self.sprites = sprites
        self.types = types
    }
    
    
    
}
