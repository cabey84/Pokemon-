//
//  PokemonSearchViewController.swift
//  JSONPokedex
//
//  Created by Chandi Abey  on 8/30/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import UIKit



class PokemonSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var baseStatLabel: UILabel!
    
    
    @IBOutlet weak var movesLabel: UILabel!

    
    //anything i put in here will be run when i click the search button
    static func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        //making sure theres a search term there
        guard let searchTerm = searchBar.text else { return }
        PokemonController.getPokemon(searchTerm) { (pokemon) in
            //first make sure theres a pokemon
            guard let pokemon = pokemon else { return }
            self.nameLabel.text = pokemon.name
            self.baseStatLabel.text = "\(pokemon.baseStat)"
            self.movesLabel.text = pokemon.move
            
            PokemonController.getSpriteEndpointForPokemon(pokemon, completion: { (endpoint) in
                guard let endpoint = endpoint else { return }
                ImageController.imageForURL(endpoint, completion: { (image) in
                    guard let image = image else { return }
                    self.image.image = image
                })
            })
        }
    }
}
