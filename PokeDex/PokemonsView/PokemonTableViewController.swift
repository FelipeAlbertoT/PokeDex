//
//  PokemonTableViewController.swift
//  PokeDex
//
//  Created by Felipe Treichel on 04/08/19.
//  Copyright © 2019 Felipe Treichel. All rights reserved.
//

import UIKit
struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
    
    static func clearTabBar(forBar tabBar: UITabBar) {
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.isTranslucent = true
    }
}

class PokemonTableViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    func updateSearchResults(for searchController: UISearchController) {
        print("toDo")
    }
    
    @IBOutlet var tableView: UITableView!
    
    var pokemons = [NamedAPIResource]()
    var pagedPokemons: PagedPokemon?
    let endpoint = "https://pokeapi.co"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // dados mockados
//        pokemons.append(Pokemon(id: 1, name: "bulbasaur", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", types: [PokemonType(name:  "poison"), PokemonType(name: "grass")]))
//        pokemons.append(Pokemon(id: 2, name: "ivysaur", sprite: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png", types: [PokemonType(name:  "poison"), PokemonType(name: "grass")]))
        
        DispatchQueue.global(qos: .utility).async {
            if let url = URL(string: "\(self.endpoint)/api/v2/pokemon/") {
                URLSession.shared.dataTask(with: url) { (data, res, err) in
                    let jsonDecoder = JSONDecoder()
                    if let data = data {
                        do {
                            self.pagedPokemons = try jsonDecoder.decode(PagedPokemon.self, from: data)
                            self.pokemons = self.pagedPokemons!.results
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        } catch {
                            print("Failed to load Pokemons")
                        }
                    }
                }.resume()
            }
        }
        
        
        self.title = "Poke"

        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
        
        if let tabController = tabBarController {
            System.clearTabBar(forBar: tabController.tabBar)
            tabController.view.backgroundColor = .clear
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        
        let pokemon = pokemons[indexPath.row]
        
        cell.setup(namedAPIResource: pokemon)
        
        return cell
    }

    // header gradiente
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView()
//        header.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 5)
//
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = header.bounds
//        gradientLayer.colors = [UIColor(named: "Color1")!.cgColor, UIColor(named: "Color2")!.cgColor, UIColor(named: "Color3")!.cgColor, UIColor(named: "Color4")!.cgColor]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
//
//        header.layer.addSublayer(gradientLayer)
//        return header
//    }
    
}
