//
//  FocusViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 12/4/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class FocusViewController: UIViewController {

    let imageName: [String] = ["pause.circle", "play.circle"]
    var focusComplete = false
    var pos = 0
    var timer = Timer()
    var breakTimer = Timer()
    var timeLeft = 25
    let totalTime = 25
    var breakTimeLeft = 5
    let breakTotalTime = 5
    var activityName: String?
    var sessionNumber: String?
    @IBOutlet weak var pauseImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timerImage: UIImageView!
    @IBOutlet weak var focusTimer: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var sessionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityLabel.text = "\(activityName!)"
        sessionLabel.text = "Session: 1 out of \(sessionNumber!)"
        focusTimer.text = timeFormatted(totalTime)
        timerImage.image = UIImage(named: "tomato")
        pauseImage.image = UIImage(systemName: imageName[0])
        countdownTimer()
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if pos == 0 {
            pauseImage.image = UIImage(systemName: imageName[1])
            pos = 1
            timer.invalidate()
            breakTimer.invalidate()
        } else if pos == 1 {
            pauseImage.image = UIImage(systemName: imageName[0])
            pos = 0
            focusComplete ? breakCountdownTimer() : countdownTimer()
        }
    }

    func countdownTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
           if timeLeft != 0 {
               timeLeft -= 1
               focusTimer.text = timeFormatted(timeLeft)
               progressBar.progress = Float(timeLeft) / Float(totalTime)
               print(Float(totalTime))
               print(Float(timeLeft))
           } else {
               timerImage.image = UIImage(named: "cucumber")
               progressBar.progressTintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
               progressBar.progress = 1.0
               pauseImage.tintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
               focusComplete = true
               focusTimer.text = timeFormatted(breakTotalTime)
               print(String(focusComplete))
               timer.invalidate()
               breakCountdownTimer()
           }
       }
    
    func breakCountdownTimer() {
            breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakUpdateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func breakUpdateTimer() {
        if breakTimeLeft != 0 {
            breakTimeLeft -= 1
            focusTimer.text = timeFormatted(breakTimeLeft)
            progressBar.progress = Float(breakTimeLeft) / Float(breakTotalTime)
        } else {
            breakTimer.invalidate()
        }
    }
    

    /// Function to format the time text
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
    
}
