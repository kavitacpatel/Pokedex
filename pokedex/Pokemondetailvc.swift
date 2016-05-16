//
//  PokemondetailvcViewController.swift
//  pokedex
//
//  Created by kavita patel on 2/21/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit


class Pokemondetailvc: UIViewController {

    
    var pokemon: Pokemon!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var attacklbl: UILabel!
    @IBOutlet weak var idlbl: UILabel!
    @IBOutlet weak var defenselbl: UILabel!
    @IBOutlet weak var heightlbl: UILabel!
    @IBOutlet weak var weightlbl: UILabel!
    @IBOutlet weak var namelbl: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        namelbl.text = pokemon.name
        idlbl.text = String(pokemon.id)
        img.image = UIImage(named: "\(self.pokemon.id)")
        
        pokemon.downloadpokedetails() {
            dispatch_async(dispatch_get_main_queue(),
                {
                    self.attacklbl.text = String(self.pokemon.baseattack)
                    self.defenselbl.text = String(self.pokemon.defense)
                    self.heightlbl.text = self.pokemon.height
                    self.weightlbl.text = self.pokemon.weight
                    super.viewWillAppear(true)
            })
        }
    }
  }
