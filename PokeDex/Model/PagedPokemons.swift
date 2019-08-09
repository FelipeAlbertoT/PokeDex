//
//  PagedPokemons.swift
//  PokeDex
//
//  Created by Felipe Treichel on 09/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import Foundation

class PagedPokemon: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [NamedAPIResource]
    
    init(count: Int, next: URL?, previous: URL?, results: [NamedAPIResource]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}
