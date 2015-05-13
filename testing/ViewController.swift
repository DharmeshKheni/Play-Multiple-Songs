//
//  ViewController.swift
//  testing
//
//  Created by Anil on 13/05/15.
//  Copyright (c) 2015 Variya Soft Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import MediaPlayer

public var audioPlayer = AVPlayer()
public var selectedSongNumber = Int()
public var songPlaylist:[String] = ["Miley_Cyrus_", "We_Are_One_Ole_Ola_"]
public var recentSong = "Miley_Cyrus_"

protocol AudioPlayerDelegate: class {
    func finishedPlaying(sender:AnyObject)
}

class ViewController: UIViewController,  AVAudioPlayerDelegate {
    
    @IBOutlet weak var musicSlider: UISlider!
    
    @IBOutlet weak var PlayPause: UIButton!
    weak var delegate : AudioPlayerDelegate?
    var audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
        NSBundle.mainBundle().pathForResource(recentSong, ofType: "mp3")!), error: nil)
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        delegate?.finishedPlaying(self)
        changeSong()
        println("Finished Playing Audio")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer.delegate = self
        
        musicSlider.maximumValue = Float(audioPlayer.duration)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("updateMusicSlider"), userInfo: nil, repeats: true)
    }
    
    func changeSong()  {

        var recentSong = songPlaylist[selectedSongNumber + 1]
        println(recentSong)
        audioPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath:
            NSBundle.mainBundle().pathForResource(recentSong, ofType: "mp3")!), error: nil)
        audioPlayer.play()
        
    }
    
    @IBAction func PlayPauseButton(sender: AnyObject) {
        
        if !audioPlayer.playing{
            audioPlayer.play()
            
        }else{
            audioPlayer.pause()
        
        }
    }
    
    @IBAction func StopButton(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
    
    }
    
    @IBAction func musicSliderAction(sender: UISlider) {
        audioPlayer.stop()
        audioPlayer.currentTime = NSTimeInterval(musicSlider.value)
        audioPlayer.play()
        
    }
    
    func updateMusicSlider(){
        
        musicSlider.value = Float(audioPlayer.currentTime)
        
    }
    deinit {
        audioPlayer?.delegate = nil
    }
}

