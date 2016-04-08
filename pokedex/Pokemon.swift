//
//  pokemon.swift
//  pokedex
//
//  Created by kavita patel on 2/20/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import Foundation

class pokemon
{
    private var _name: String!
    private var _id: Int!
    
    var name: String
        {
        return _name
    }
    var id: Int
        {
        return _id
    }
    init(name: String, id: Int)
    {
self._name =  name
        self._id = id
    }
}