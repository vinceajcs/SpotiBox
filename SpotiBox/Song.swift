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
        var duration: String
        var imageURL: String
        var songURL: String
    }
    
    var songArray = [SongData]()
    var searchURL: String!
    
    func getSongDetails(completed: @escaping () -> ()) {
        let auth = SPTAuth.defaultInstance()!
        
        songArray = []
        
        Alamofire.request(searchURL, method: .get, parameters: ["q":"Shawn Mendes", "type":"track"], encoding: URLEncoding.default, headers: ["Authorization": "Bearer " + auth.session.accessToken]).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let JSONSongsArray = json["tracks"]["items"]
                let numberOfSongs = JSONSongsArray.count
                
                for index in 0...numberOfSongs-1 {
                    let name = json["tracks"]["items"][index]["name"].stringValue
                    
                    let durationInMS = json["tracks"]["items"][index]["duration_ms"].doubleValue
                    let duration = Int(durationInMS).msToSeconds.minuteSecondMS
                    
                    let imageURL = json["tracks"]["items"][index]["album"]["images"][0]["url"].stringValue
                    
                    let songURL = json["tracks"]["items"][index]["uri"].stringValue
                    
                    self.songArray.append(SongData(name: name, duration: duration, imageURL: imageURL, songURL: songURL))
                }
                
                
            case .failure(let error):
                print("ERROR: \(error) failed to get data from url \(self.searchURL)")
            }
            completed()
        }
    }
    
}

//used to convert song duration from ms to minutes
extension TimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d", minute, second)
    }
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}

extension Int {
    var msToSeconds: Double {
        return Double(self) / 1000
    }
}

