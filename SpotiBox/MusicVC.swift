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
    
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var playButton: UIImageView!
    
    var song: String!
    var artist: String!
    var imageURL: String!
    var songURL: String!
    var durationInSeconds: Double!
    
    var timeElapsed: Float = 0
    var songFinished = false
    var previousSliderValue: Float = 0
    
    var playTimer: Timer!
    var sliderTimer: Timer!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInterface()
        MediaPlayer.shared.play(track: songURL)
        
        playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
        
        sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        
        navigationItem.title = artist.uppercased()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem?.title = "hey"
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //stop both timers if we go back to the list of songs
        playTimer.invalidate()
        sliderTimer.invalidate()
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
        
        slider.isContinuous = false
        
    }
    
    @objc func updatePlayButton(){
        if !MediaPlayer.shared.isPlaying && slider.value == 1 {
            playButton.image = UIImage(named: "play")
            songFinished = true
            
            playTimer.invalidate()
            sliderTimer.invalidate()
        } else {
            playButton.image = UIImage(named: "pause")
        }
        
    }
    
    @objc func updateSlider() {
        timeElapsed += 1
        slider.value = Float(timeElapsed) / Float(durationInSeconds)
        print("***\(slider.value)")
    }
    
    
    @IBAction func sliderDragged(_ sender: UISlider) {
        if songFinished {
            MediaPlayer.shared.play(track: songURL)
            MediaPlayer.shared.seek(progress: slider.value, songDuration: durationInSeconds)
            songFinished = false
            
            if !playTimer.isValid && !sliderTimer.isValid {
                print("Song finished but slider dragged - turn timers back on.")
                playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)

                sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            }
            
        } else {
            MediaPlayer.shared.seek(progress: slider.value, songDuration: durationInSeconds)
        }
        
        //update timeElapsed in song
        timeElapsed = slider.value * Float(durationInSeconds)
        
    }
    
    
    @IBAction func playButtonTapped(_ sender: UITapGestureRecognizer) {
        if MediaPlayer.shared.isPlaying {
            MediaPlayer.shared.pause()
            playButton.image = UIImage(named: "play")
            
            if playTimer.isValid && sliderTimer.isValid {
                print("Turn timers off after pause button tapped.")
                playTimer.invalidate()
                sliderTimer.invalidate()
            }
            
        } else {
            if slider.value == 1 {
                timeElapsed = 0
                print("Play button tapped. Song is finished. Play from beginning.")
                MediaPlayer.shared.play(track: songURL)
            } else {
                MediaPlayer.shared.resume()
            }
            
            playButton.image = UIImage(named: "pause")

            if !playTimer.isValid && !sliderTimer.isValid {
                print("Turn timers on after play button tapped.")
                playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
                
                sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            }
        }
        
    }


}
