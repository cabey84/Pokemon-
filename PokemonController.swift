//
//  PokemonController.swift
//  JSONPokedex
//
//  Created by Chandi Abey  on 8/30/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class PokemonController {
    
    static let baseURL = "http://pokeapi.co/api/v2/pokemon"
    
    //lets make a static function so we dont have to make a singleton, need a search term, completion closure parameter is the data you want back
    static func getPokemon(searchTerm: String, completion: (pokemon: Pokemon?) -> Void) {
        let searchURL = baseURL + searchTerm.lowercaseString
        
        //turning string into a URL, semicolon turns else statement into one line
        guard let url = NSURL(string: searchURL) else { completion(pokemon: nil); return }
        
        //how do we try to get data from URL? call networkcontroller
        NetworkController.performRequestForURL(url, httpMethod: .Get, completion: { (data, error) in
            
            //serialize the data, JSON is still anyobject
            guard let data = data,
                JSONDictionary = (try? NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject]
                else { completion(pokemon:nil); return }
            
            //NOTE: yesterday's project, we parsed down here. but today, we parsed down the JSON in the initializer.
            
            //what do we want to do with this JSON?
            let pokemon = Pokemon(dictionary: JSONDictionary)
            
            //all the other stuff is happening on a background thread, we want to move it to the main thread in order to update the UI
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion(pokemon: pokemon)
                
            })
        })
    }
    
    static func getSpriteEndpointForPokemon(pokemon: Pokemon, completion: (endpoint: String?) -> Void) {
        guard let url = NSURL(string: pokemon.imageEndPoint) else { completion(endpoint: nil); return }
        
        NetworkController.performRequestForURL(url, httpMethod: .Get) { (data, error) in
            guard let data = data, JSONDictionary = (try?NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as? [String: AnyObject], spritesDictionary = JSONDictionary["sprites"] as? [String: AnyObject], spriteEndpoint = spritesDictionary["front_default"] as? String else { completion(endpoint: nil);return }
            
            completion(endpoint: spriteEndpoint)
            
        }
    }
    
}




