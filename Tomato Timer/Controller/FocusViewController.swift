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
    var breakComplete = false
    var sessionComplete = false
    var currentSession = 1
    var pos = 0
    var timeLeft = 5
    let totalTime = 5
    var breakTimeLeft = 5
    let breakTotalTime = 5
    var activityName: String?
    var sessionNumber: String?
    var timer = Timer()
    var breakTimer = Timer()
    @IBOutlet weak var pauseImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timerImage: UIImageView!
    @IBOutlet weak var focusTimer: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var sessionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityLabel.text = "\(activityName!)"
        sessionLabel.text = "Session: \(currentSession) out of \(sessionNumber!)"
        pauseImage.image = UIImage(systemName: imageName[0])
        focusScreen()
        countdownTimer()
    }
    
    func focusScreen() {
        timerImage.image = UIImage(named: "tomato")
        sessionLabel.text = "Session: \(currentSession) out of \(sessionNumber!)"
        progressBar.progress = 1.0
        progressBar.progressTintColor = UIColor(red: 0.78, green: 0.10, blue: 0.07, alpha: 1.00)
        pauseImage.tintColor = UIColor(red: 0.78, green: 0.10, blue: 0.07, alpha: 1.00)
        focusTimer.text = timeFormatted(totalTime)
    }
    
    func breakScreen() {
        timerImage.image = UIImage(named: "cucumber")
        sessionLabel.text = "Session: \(currentSession) out of \(sessionNumber!)"
        progressBar.progress = 1.0
        progressBar.progressTintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
        pauseImage.tintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
        focusTimer.text = timeFormatted(breakTotalTime)
    }

    /// Function to format the time text
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%01d:%02d", minutes, seconds)
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
           } else {
               timer.invalidate()
               focusComplete = true
               breakScreen()
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
            breakComplete = true
            breakTimer.invalidate()
            checkCurrentSession()
        }
    }
    
    func checkCurrentSession() {
        let totalSession = Int(sessionNumber!)
        if currentSession == totalSession {
            let alert = UIAlertController(title: "Congrats!", message: "You have completed all the sessions.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            currentSession += 1
            focusComplete = false
            breakComplete = false
            focusScreen()
            countdownTimer()
        }
    }
    
}
