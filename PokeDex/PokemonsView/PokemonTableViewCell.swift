//
//  PokemonTableViewCell.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    var pokemon: Pokemon? = nil
    
    @IBOutlet var pokemonImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var type1: UIImageView!
    @IBOutlet var type2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func resetCell() {
        self.pokemonImage.image = UIImage()
        self.name.text = ""
        self.id.text = ""
        self.type1.image = UIImage()
        self.type2.image = UIImage()
    }
    
    func setup(pokemon: Pokemon) {
        self.name.text = pokemon.name
        self.id.text = String(format: "#%03d", pokemon.id)
        self.pokemonImage.image = pokemon.sprites.image
        for (index, type) in pokemon.types.enumerated() {
            let typeImage = UIImage(named: type.name.capitalized)
            
            DispatchQueue.main.async {
                if index == 0 {
                    self.type1.image = typeImage
                    self.type2.image = UIImage()
                } else {
                    self.type2.image = typeImage
                }
            }
        }
    }
    
}
