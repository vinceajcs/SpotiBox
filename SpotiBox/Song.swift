//
//  Song.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 11/30/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Song {
    
    struct SongData {
        var name: String
        var imageURL: String
    }
    
    var songArray = [SongData]()
    var songURL = "https://api.spotify.com/v1/search?q=Shawn+Mendes&type=track"
    
    func getSongDetails(completed: @escaping () -> ()) {
        let auth = SPTAuth.defaultInstance()!
        
        Alamofire.request(songURL, method: .get, parameters: ["q":"Shawn Mendes", "type":"track"], encoding: URLEncoding.default, headers: ["Authorization": "Bearer " + auth.session.accessToken]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let JSONSongsArray = json["tracks"]["items"]
                let numberOfSongs = JSONSongsArray.count
                
                for index in 0...numberOfSongs-1 {
                    let name = json["tracks"]["items"][index]["name"].stringValue
                    let imageURL = json["tracks"]["items"][index]["album"]["images"][0]["url"].stringValue
                    self.songArray.append(SongData(name: name, imageURL: imageURL))
                }
                
                
            case .failure(let error):
                print("ERROR: \(error) failed to get data from url \(self.songURL)")
            }
            completed()
        }
    }
    
    
    
    
    
}

