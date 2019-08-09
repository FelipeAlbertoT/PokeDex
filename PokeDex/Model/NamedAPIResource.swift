//
//  PokemonType.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import Foundation

class NamedAPIResource: NSObject, Codable {
    
    let name: String
    let url: URL
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }}
