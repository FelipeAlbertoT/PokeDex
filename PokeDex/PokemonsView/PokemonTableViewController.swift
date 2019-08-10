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
    
    var pokemons = [Pokemon]()
    var pagedPokemons: PagedPokemon?
    let endpoint = "https://pokeapi.co"
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let url = URL(string: "\(self.endpoint)/api/v2/pokemon/") {
            PokemonService.fetchPokemons(from: url, completion: populatePokemons)
        }
        
        if let navController = navigationController {
            System.clearNavigationBar(forBar: navController.navigationBar)
            navController.view.backgroundColor = .clear
        }
        
        if let tabController = tabBarController {
            System.clearTabBar(forBar: tabController.tabBar)
            tabController.view.backgroundColor = .clear
        }
        
        
    }
    
    func populatePokemons(pagedPokemons: PagedPokemon?, err: Error?) {
        self.pagedPokemons = pagedPokemons
        var count = 0
        self.pagedPokemons?.results.forEach({ (namedAPIResource) in
            PokemonService.fetchPokemon(from: namedAPIResource.url, completion: { (pokemon, error) in
                guard let pokemon = pokemon else {
                    print("Erro ao bucar pokemon: \(error!)")
                    return
                }
                self.pokemons.append(pokemon)
                self.pokemons.sort(by: { (pokemon1, pokemon2) -> Bool in
                    return pokemon1.id < pokemon2.id
                })
//                let i = self.pokemons.firstIndex(of: pokemon)!
                count += 1
                if count == 20 {
                    self.fetchingMore = false
                    DispatchQueue.main.sync {
//                        self.tableView.insertRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
                        self.tableView.reloadData()
                    }
                }
            })
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonTableViewCell
        cell.resetCell()
        
        if let pokemon = try? pokemons[indexPath.row] {
            cell.setup(pokemon: pokemon)
        }
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.height
        
        if offsetY > contentHeight - frameHeight * 4 {
            if !fetchingMore {
                fetchMorePokemons()
            }
        }
    }
    
    func fetchMorePokemons() {
        self.fetchingMore = true
        PokemonService.fetchPokemons(from: self.pagedPokemons?.next, completion: populatePokemons)
    }
}
