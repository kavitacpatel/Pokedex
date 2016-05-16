//
//  MusicPlayer.swift
//  pokedex
//
//  Created by kavita patel on 5/16/16.
//  Copyright © 2016 kavita patel. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayer
{
   static var sharedInstance = MusicPlayer()
   var isMusic = false
   var player: AVAudioPlayer!
    init()
    {
        play()
    }
    func play()
    {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        do{
            player = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            player.prepareToPlay()
            player.numberOfLoops = -1
        }catch let err as NSError
        {
            print(err.description)
        }
    }
}