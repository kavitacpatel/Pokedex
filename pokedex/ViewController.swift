//
//  ViewController.swift
//  pokedex
//
//  Created by kavita patel on 2/20/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var musicBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var isSearch = false
   // var isMusic = true
    var pokemon = [Pokemon]()
    var filterPokemon = [Pokemon]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.Done
        parsecsv()
        //MusicPlayer.sharedInstance.play()
    }
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        if MusicPlayer.sharedInstance.isMusic
        {
            MusicPlayer.sharedInstance.player.play()
            musicBtn.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar)
    {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchBar.text == nil || searchBar.text == ""
        {
            isSearch = false
            view.endEditing(true)
        }
        else
        {
            isSearch = true
            let lower = searchBar.text!.lowercaseString
            filterPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collectionView.reloadData()
        }
    }
    
    func parsecsv()
    {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        do
        {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            for row in rows
            {
                let pokeid = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, id: pokeid)
                pokemon.append(poke)
            
            }
        }catch let err as NSError
        {
            print(err.description)
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Pokecell", forIndexPath: indexPath) as? pokecell
        {
            var poke: Pokemon!
            if isSearch
            {
                poke = filterPokemon[indexPath.row]
                
            }
            else
            {
               poke = pokemon[indexPath.row]
            }
            
            cell.configcell(poke)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pok: Pokemon!
        if isSearch
        {
            pok = filterPokemon[indexPath.row]
        }else
        {
            pok = pokemon[indexPath.row]
            
        }
        performSegueWithIdentifier("Pokemondetailvc", sender: pok)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Pokemondetailvc"
        {
            if let detailvc = segue.destinationViewController as? Pokemondetailvc
            {
                if let pok = sender as? Pokemon
                {
                    detailvc.pokemon = pok
                }
            }
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearch
        {
            return filterPokemon.count
        }
        
        return pokemon.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, 100)
    }

    @IBAction func sound(sender: UIButton) {
        if MusicPlayer.sharedInstance.isMusic
        {
            MusicPlayer.sharedInstance.player.stop()
            MusicPlayer.sharedInstance.isMusic = false
            sender.alpha = 0.2
        }
        else
        {
            MusicPlayer.sharedInstance.player.play()
            MusicPlayer.sharedInstance.isMusic = true
            sender.alpha = 1.0
        }
    }
}

