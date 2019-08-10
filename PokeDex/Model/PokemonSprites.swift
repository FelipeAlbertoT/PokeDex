//
//  PokemonSprites.swift
//  PokeDex
//
//  Created by Felipe Treichel on 09/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

class PokemonSprites: Codable {
    
    let frontDefault: URL
    var image: UIImage?
//    let front_shiny: String
//    let front_female: String
//    let front_shiny_female: String
//    let back_default: String
//    let back_shiny: String
//    let back_female: String
//    let back_shiny_female: String
    
    enum CodingKeys : String, CodingKey {
        case frontDefault = "front_default"
        case image
    }
    
    init(frontDefault: URL) {
        self.frontDefault = frontDefault
        self.image = UIImage()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decode(URL.self, forKey: .frontDefault)
        self.image = UIImage()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(frontDefault, forKey: .frontDefault)
    }
}
