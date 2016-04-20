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

    var pokemon = [Pokemon]()
    var player: AVAudioPlayer!
    var filterpokemon = [Pokemon]()
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    var issearch = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searchbar.delegate = self
        searchbar.returnKeyType = UIReturnKeyType.Done
        play()
        parsecsv()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchbar.text == nil || searchbar.text == ""
        {
            issearch = false
            view.endEditing(true)
        }
        else
        {
            issearch = true
            
            let lower = searchbar.text!.lowercaseString
            filterpokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            
            collection.reloadData()
        }
    }
    
    func play()
    {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do{
            player = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            player.prepareToPlay()
            player.numberOfLoops = -1
            player.play()
        }catch let err as NSError
        {
            print(err.description)
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
            if issearch
            {
                poke = filterpokemon[indexPath.row]
                
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
        if issearch
        {
            pok = filterpokemon[indexPath.row]
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
        if issearch
        {
            return filterpokemon.count
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
        if player.playing
        {
            player.stop()
            sender.alpha = 0.2
        }
        else
        {
            player.play()
            sender.alpha = 1.0
        }
    }
}

