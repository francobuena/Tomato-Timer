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
    var pos = 0
    var timer = Timer()
    var focusValue = 25
    let totalTime = 25
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
        focusTimer.text = "\(focusValue)"
        timerImage.image = UIImage(named: "tomato")
        pauseImage.image = UIImage(systemName: imageName[0])
        countdownTimer()
    }

    func countdownTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func pauseButton(_ sender: Any) {
        if pos == 0 {
            pauseImage.image = UIImage(systemName: imageName[1])
            pos = 1
            timer.invalidate()
        } else if pos == 1 {
            pauseImage.image = UIImage(systemName: imageName[0])
            pos = 0
            countdownTimer()
        }
    }
    
    @objc func updateTimer() {
        if focusValue != 0 {
            focusValue -= 1
            focusTimer.text = String(format: "%02d", focusValue)
            progressBar.progress = Float(focusValue) / Float(totalTime)
            print(Float(totalTime))
            print(Float(focusValue))
        } else {
            timerImage.image = UIImage(named: "cucumber")
            progressBar.progressTintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
            progressBar.progress = 1.0
            pauseImage.tintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
            focusTimer.text = "5:00"
            timer.invalidate()
        }
    }
    
}
