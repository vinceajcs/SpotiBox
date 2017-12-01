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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = song.songArray[indexPath.row].name
        return cell
    }
}
