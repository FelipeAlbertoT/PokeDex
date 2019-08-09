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
    
    func setup(namedAPIResource: NamedAPIResource) {
        self.name.text = namedAPIResource.name
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: namedAPIResource.url) { (data, res, err) in
                let jsonDecoder = JSONDecoder()
                if let data = data {
                    do {
                        self.pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                        
                        if let pokemon = self.pokemon {
                            DispatchQueue.main.async {
                                self.id.text = String(format: "#%03d", pokemon.id)
                            
                                do{
                                    let data = try Data(contentsOf: pokemon.sprites.frontDefault)
                                    self.pokemonImage.image = UIImage(data: data)
                                } catch {
                                    print("Falha ao carregar a imagem do pokemon")
                                }
                    
                                for (index, type) in pokemon.types.enumerated() {
                                    let typeImage = UIImage(named: type.name.capitalized)
                                    if index == 0 {
                                        self.type1.image = typeImage
                                        self.type2.image = UIImage()
                                    } else {
                                        self.type2.image = typeImage
                                    }
                                }
                            }
                        }
                        
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
                    } catch {
                        print("Failed to load Pokemons")
                    }
                }
            }.resume()
        }
//        self.id.text = String(format: "#%03d", pokemon.id)
        
//        let url = URL(string: pokemon.sprite)
//        do{
//            let data = try Data(contentsOf: url!)
//            self.pokemonImage.image = UIImage(data: data)
//        } catch {
//            print("Falha ao carregar a imagem do pokemon")
//        }
    
//        for (index, type) in pokemon.types.enumerated() {
//            let typeImage = UIImage(named: type.name.capitalized)
//            if index == 0 {
//                type1.image = typeImage
//            } else {
//                type2.image = typeImage
//            }
//        }
    }
    
}
