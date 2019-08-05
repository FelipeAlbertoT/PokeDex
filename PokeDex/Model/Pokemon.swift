//
//  Pokemon.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import Foundation

class Pokemon: NSObject {
    
    let id: Int
    let name: String
    let sprite: String
    let types: [PokemonType]
    
    init(id: Int, name: String, sprite: String, types: [PokemonType]) {
        self.id = id
        self.name = name
        self.sprite = sprite
        self.types = types
    }
    
}
