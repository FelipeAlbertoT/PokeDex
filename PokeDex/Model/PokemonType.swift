//
//  PokemonType.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import Foundation

class PokemonType: NSObject, Codable {
    
    let slot: Int
    let name: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case slot
        case type
    }
    enum typeCodingKeys: String, CodingKey {
        case name
        case url
    }
    
    init(slot: Int, name: String, url: URL) {
        self.slot = slot
        self.name = name
        self.url = url
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.nestedContainer(keyedBy: typeCodingKeys.self, forKey: .type)
        
        
        self.slot = try container.decode(Int.self, forKey: .slot)
        self.name = try type.decode(String.self, forKey: .name)
        self.url = try type.decode(URL.self, forKey: .url)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(
            keyedBy: CodingKeys.self)
        
        var type = container.nestedContainer(
            keyedBy: typeCodingKeys.self, forKey: .type)
        try type.encode(name, forKey: .name)
        try type.encode(url, forKey: .url)
    }
}
