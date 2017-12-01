//
//  SongCell.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 11/30/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var cellSongImage: UIImageView!
    @IBOutlet weak var cellSongName: UILabel!
    @IBOutlet weak var cellSongDuration: UILabel!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
