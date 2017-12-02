//
//  MediaPlayer.swift
//  SpotiBox
//
//  Created by Vincent Stephen Huang on 12/1/17.
//  Copyright © 2017 Huang. All rights reserved.
//

import Foundation
import AVFoundation

class MediaPlayer: NSObject, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    static let shared = MediaPlayer()
    
    var player: SPTAudioStreamingController?
    
    var isPlaying: Bool {
        if let player = player,
            let state = player.playbackState {
            return state.isPlaying
        }
        return false
    }
    
    func play(track: String) {
        player?.playSpotifyURI(track, startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if let error = error {
                print("There was an error playing the track \(track), this is the error: \(error)")
            }
        })
    }
    
    func resume() {
        player?.setIsPlaying(true, callback: { (error) in
            if let error = error {
                print("Couldn't resume play. Here's the error: \(error)")
            }
        })
    }
    
    func pause() {
        player?.setIsPlaying(false, callback: { (error) in
            if let error = error {
                print("Something went wrong trying to pause the track. Here's the error: \(error)")
            }
        })
    }
    
//    func seek(progress: Float, songDuration: Double) {
//       player?.seek(to: Double(progress) * songDuration, callback: { (error) in
//            if let error = error {
//                print("Something went wrong trying to seek the track. Here's the error: \(error)")
//            }
//       })
    
    func seek(progress: Float, songDuration: Double) {
        player?.seek(to: Double(progress) * songDuration, callback: { (error) in
                        if let error = error {
                            print("Something went wrong trying to seek the track. Here's the error: \(error)")
                        }
                   })
    }
    

    

    
    func configurePlayer(authSession: SPTSession, id: String) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try? player!.start(withClientId: id)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
    
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        print("Signed into audioStreaming!")
    }
    
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didReceiveError error: Error!) {
        print("Wasn't able to sign into audioStreaming: \(error)")
    }
    
   
    
}
