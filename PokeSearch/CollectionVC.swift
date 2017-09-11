//
//  CollectionVC.swift
//  PokeSearch
//
//  Created by Hongbo Niu on 2017-09-08.
//  Copyright © 2017 Udemy. All rights reserved.
//

import UIKit

protocol PokemonSentDelegate{
    func userDidSelectPoke(poke: Pokemon)
}

class CollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var delegate:PokemonSentDelegate?
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredPokemon = [String]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
        
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            var poke: Pokemon!
            if inSearchMode {
                let index = pokemons.index(of: filteredPokemon[indexPath.row])
                poke = Pokemon(pokedexId: index!, name: filteredPokemon[indexPath.row])
            } else{
                poke = Pokemon(pokedexId: indexPath.row)
            }
            
            cell.configureCell(pokemon: poke)
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            let index = pokemons.index(of: filteredPokemon[indexPath.row])
            poke = Pokemon(pokedexId: index!, name: filteredPokemon[indexPath.row])
        } else{
            poke = Pokemon(pokedexId: indexPath.row)
        }
        
        if poke != nil && delegate != nil {
            print(poke.name)
            delegate?.userDidSelectPoke(poke: poke)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemon.count
        }
        
        return pokemons.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 105, height: 105)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemons.filter({nil != $0.range(of: lower)})
        }
        
        collection.reloadData()
        
    }
}
