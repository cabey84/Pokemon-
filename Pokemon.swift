//
//  Pokemon.swift
//  JSONPokedex
//
//  Created by Chandi Abey  on 8/30/16.
//  Copyright © 2016 Chandi Abey . All rights reserved.
//

import Foundation

class Pokemon {
    
    //getting value out of JSON
    private let kName = "name"
    private let kForms = "forms"
    private let kURL = "url"
    private let kStats = "stats"
    private let kBaseStat = "base_stat"
    private let kMoves = "moves"
    private let kMoveName = "name"
    
    let name: String
    //b/c it will be an image when we get it back
    let imageEndPoint: String
    let baseStat: Int
    //an array b/c more than one move
    let moves: String
    

    init?(dictionary: [String: AnyObject]) {
        //compiler doesnt know what type it is thats why we have to cast it
        guard let name = dictionary[kName] as? String,
            //we have to pull the value of forms out of the forms array
            formsArray = dictionary[kForms] as? [[String: AnyObject]],
            //use index to get value of URL out
            //use .first syntax instead of index to avoid optional returning nil and crashing
            formsDictionary = formsArray.first,
            //cast as string
            URL = formsDictionary[kURL] as? String,
            
            statArray = dictionary[kStats] as? [[String: AnyObject]],
            statDictionary = statArray.first,
            baseStat = statDictionary[kBaseStat] as? Int,
        
            movesArray = dictionary[kMoves] as? [[String: AnyObject]],
            movesDictionary = movesArray.first,
            //This part tripped me up, look back!
            moveDictionary = movesDictionary["move"] as? [String: AnyObject],
            move = movesDictionary[kMoveName] as? String
        
          else { return nil }
        
            self.name = name
            self.imageEndPoint = URL
            self.baseStat = baseStat
            self.moves = move
        
        
    }
        
        
}
    
    
    