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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var song = Song()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //log into audio streaming
        LoginManager.shared.preparePlayer()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //prepares segue from this VC to MusicVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MusicVC
        if let selectedRow = tableView.indexPathForSelectedRow?.row {
            destination.song = song.songArray[selectedRow].name
            destination.imageURL = song.songArray[selectedRow].imageURL
            destination.songURL = song.songArray[selectedRow].songURL
            destination.durationInSeconds = song.songArray[selectedRow].durationInSeconds
        }
    }
}

extension TableViewVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchBarPressed!")
        let search = searchBar.text
        let keywords = search?.replacingOccurrences(of: " ", with: "+")
        
        //every time the searchBar is "clicked", the searchURL is updated
        song.searchURL = "https://api.spotify.com/v1/search?q=\(keywords!)&type=track"

        self.view.endEditing(true)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        song.getSongDetails {
            self.tableView.reloadData()
        }

        return true
    }
}

extension TableViewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return song.songArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        
        cell.cellSongName.text = song.songArray[indexPath.row].name
        
        cell.cellSongDuration.text = song.songArray[indexPath.row].duration
        
        //get image from imageURL
        guard let url = URL(string: song.songArray[indexPath.row].imageURL) else {
            return cell //presumably returns cell without image
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
