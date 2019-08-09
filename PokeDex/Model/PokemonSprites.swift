//
//  PokemonSprites.swift
//  PokeDex
//
//  Created by Felipe Treichel on 09/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import Foundation

class PokemonSprites: Codable {
    
    let frontDefault: URL
//    let front_shiny: String
//    let front_female: String
//    let front_shiny_female: String
//    let back_default: String
//    let back_shiny: String
//    let back_female: String
//    let back_shiny_female: String
    
    enum CodingKeys : String, CodingKey {
        case frontDefault = "front_default"
    }
    
    init(frontDefault: URL) {
        self.frontDefault = frontDefault
    }
}
