//
//  TableViewVC.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 11/30/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewVC: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    
    var song = Song()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        song.getSongDetails {
            self.tableView.reloadData()
        }
    }
    

}

extension TableViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        
        cell.cellSongName.text = song.songArray[indexPath.row].name
        
        //get image from imageURL
        guard let url = URL(string: song.songArray[indexPath.row].imageURL) else {
            return cell
        }
        
        do {
            let data = try Data(contentsOf: url)
            cell.cellSongImage.image = UIImage(data: data)
        } catch {
            print("ERROR: error thrown trying to get data from URL \(url)")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
