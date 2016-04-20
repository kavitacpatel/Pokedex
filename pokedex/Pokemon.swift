//
//  pokemon.swift
//  pokedex
//
//  Created by kavita patel on 2/20/16.
//  Copyright © 2016 kavita patel. All rights reserved.
// http://pokeapi.co/api/v1/pokemon/3/

import Foundation


class Pokemon
{
    private var _name: String!
    private var _id: Int!
    private var _weight: String!
    private var _height: String!
    private var _defense: Int!
    private var _type: String!
    private var _baseattack: Int!
    private var _description: String!
    private var _pokeurl: String!
    
    var name: String
        {
            if _name == nil
            {
                _name = ""
            }
        return _name
    }
    var id: Int
        {
           
        return _id
    }
    var weight: String
        {
            if _weight == nil
            {
                _weight = ""
            }
            return _weight
    }
    var height: String
        {
            if _height == nil
            {
                _height = ""
            }
            return _height
    }
    var defense: Int
        {
            if _defense == nil
            {
                _defense = 0
            }
            return _defense
    }
    var baseattack: Int
        {
            if _baseattack == nil
            {
                _baseattack = 0
            }

            return _baseattack
    }
    var descri: String
        {
            if _description == nil
            {
                _description = ""
            }

            return _description
    }
    var poktype: String
        {
            if _type == nil
            {
                _type = ""
            }

            return _type
    }
    init()
    {
        
    }
        init(name: String, id: Int)
    {
self._name =  name
        self._id = id
        _pokeurl = "\(url_base)\(url_poke)\(self._id)/"
        
    }
    func downloadpokedetails(completed:() -> ())
    {
        let url = NSURL(string: _pokeurl)!
        print(url)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
         
            do
            {
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                self._weight = result.valueForKeyPath("weight") as? String
                self._height = result.valueForKeyPath("height") as? String
                self._baseattack = result.valueForKeyPath("attack") as? Int
                self._defense = result.valueForKeyPath("defense") as? Int
                
               
                completed()
            }
            catch
            {
                print("error in getting data")
            }
            
        }
        
        task.resume()
        
   
}
}





            


