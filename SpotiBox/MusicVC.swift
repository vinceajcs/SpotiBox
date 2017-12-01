//
//  MusicVC.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 11/30/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import UIKit

class MusicVC: UIViewController {
    
    
    @IBOutlet weak var albumCoverImage: UIImageView!
    @IBOutlet weak var songName: UILabel!
    
    var song: String!
    var imageURL: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
        // Do any additional setup after loading the view.
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
            print("ERROR: error thrown trying to get data from URL \(url)")
        }
    }
    

    

}
