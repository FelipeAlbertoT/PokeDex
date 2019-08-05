//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    let pokemon: Pokemon? = nil
    
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var type1: UIImageView!
    @IBOutlet var type2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(pokemon: Pokemon) {
        self.name.text = pokemon.name
        self.id.text = String(format: "#%03d", pokemon.id)
        
        let url = URL(string: pokemon.sprite)
        let data = try? Data(contentsOf: url!)
        self.pokemonImage.image = UIImage(data: data!)
        
        for (index, type) in pokemon.types.enumerated() {
            let typeImage = UIImage(named: type.name.capitalized)
            if index == 0 {
                type1.image = typeImage
            } else {
                type2.image = typeImage
            }
        }
    }
    
}
