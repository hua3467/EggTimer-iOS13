//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var prograssBar: UIProgressView!
    @IBOutlet weak var stopBtn: UIButton!
    
    let eggTimes = [
        "Soft": 10,
        "Medium": 420,
        "Hard": 720
    ]
    
    var secondsRemaining = 60
    var secondsPassed = 0
    var hardness: String = ""
    var timer = Timer()
    var alarmPlayer: AVAudioPlayer!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        
        hardness = sender.currentTitle!  // swift doesn't know if the sender has a title or not. So it is an optional.
        titleLabel.text = hardness
        secondsRemaining = eggTimes[hardness]! - secondsPassed
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    @IBAction func stopPressed(_ sender: UIButton) {
        stopBtn.isHidden = true
        titleLabel.text = "How do you like your eggs?"
        alarmPlayer.stop()
        secondsPassed = 0
        prograssBar.progress = 0
    }
    
    
    @objc func updateTimer(){
        if secondsRemaining > 0 {
            
            secondsPassed += 1
            print("\(secondsRemaining) seconds.")
            secondsRemaining -= 1
            
            prograssBar.progress = Float(secondsPassed) / Float(eggTimes[hardness]!)
        } else {
            titleLabel.text = "DONE!"
            timer.invalidate()
            playAlarm()
            stopBtn.isHidden = false
            secondsPassed = 0
            secondsRemaining = 60
            prograssBar.progress = 0
        }
    }
    
    func playAlarm(){
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        alarmPlayer = try! AVAudioPlayer(contentsOf: url!)
        alarmPlayer.play()
    }
    
}
