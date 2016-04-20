//
//  pokecell.swift
//  pokedex
//
//  Created by kavita patel on 2/20/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import UIKit

class pokecell: UICollectionViewCell {
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var pkeimg: UIImageView!
    var pokemon: Pokemon!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
    func configcell(pokemon: Pokemon)
    {
        self.pokemon = pokemon
        namelbl.text = self.pokemon.name.capitalizedString
        pkeimg.image = UIImage(named: "\(self.pokemon.id)")
        
        
    }
}
