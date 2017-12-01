//
//  MusicVC.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 11/30/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import UIKit
import AVFoundation

class MusicVC: UIViewController {
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    
    @IBOutlet weak var playButton: UIImageView!
    
    var song: String!
    var imageURL: String!
    var songURL: String!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
        MediaPlayer.shared.play(track: songURL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUserInterface() {
        songName.text = song
        guard let url = URL(string: imageURL) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            albumCoverImage.image = UIImage(data: data)
        } catch {
            print("ERROR: error trying to get data from URL \(url)")
        }
    }
    
    
    @IBAction func playButtonTapped(_ sender: UITapGestureRecognizer) {
        if MediaPlayer.shared.isPlaying {
            MediaPlayer.shared.pause()
            playButton.image = UIImage(named: "play")
        } else {
            MediaPlayer.shared.resume()
            playButton.image = UIImage(named: "pause")
        }
    }
    
    
    

}
