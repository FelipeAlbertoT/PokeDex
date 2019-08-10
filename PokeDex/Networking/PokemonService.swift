//
//  PokemonService.swift
//  PokeDex
//
//  Created by Felipe Treichel on 05/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit

class PokemonService {
    static let imageCache = NSCache<NSString, UIImage>()
    
    static func downloadImage(url: URL, completion: @escaping (_ image: UIImage?, _ error: Error? ) -> Void) {
        if let cachedImage = PokemonService.imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        } else {
            do {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    PokemonService.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
    }
    
    static func fetchPokemons(from url: URL?, completion: @escaping (_ pagedPokemons: PagedPokemon?, _ error: Error?) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            if let url = url {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    if let err = err {
                        print("API retornou erro: \(err)")
                        completion(nil, err)
                    }
                    let jsonDecoder = JSONDecoder()
                    if let data = data {
                        do {
                            let pagedPokemons = try jsonDecoder.decode(PagedPokemon.self, from: data)
                            completion(pagedPokemons, nil)
                        } catch {
                            print("Failed to load Pokemons")
                            completion(nil, error)
                        }
                    }
                }.resume()
            }
        }
    }
    
    static func fetchPokemon(from url: URL, completion: @escaping (_ pokemon: Pokemon?, _ error: Error?) -> Void) {
        DispatchQueue.global().sync {
            URLSession.shared.dataTask(with: url) { (data, res, err) in
                let jsonDecoder = JSONDecoder()
                if let data = data {
                    if let pokemon = try? jsonDecoder.decode(Pokemon.self, from: data) {
                        PokemonService.downloadImage(url: pokemon.sprites.frontDefault, completion: { (img, error) in
                            if let error = error {
                                print("Falha ao carregar a imagem do pokemon", error)
                                completion(nil, error)
                            } else {
                                DispatchQueue.main.sync {
                                    pokemon.sprites.image = img
                                }
                                completion(pokemon, nil)
                            }
                        })
                    }
                }
            }.resume()
        }
    }
}
