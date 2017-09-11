//
//  Pokemon.swift
//  PokeSearch
//
//  Created by Hongbo Niu on 2017-09-08.
//  Copyright © 2017 Udemy. All rights reserved.
//

import Foundation

class Pokemon{
    private var _name:String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexId: Int{
        return _pokedexId
    }
    
    init(pokedexId:Int){
        self._pokedexId = pokedexId
        self._name = pokemons[pokedexId]
    }
    
    init(pokedexId: Int, name: String){
        self._pokedexId = pokedexId
        self._name = name
    }
    
}
