//
//  FocusViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 12/4/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

protocol CompletionDelegate: class {
    func didCompleteSession(activityName: String, sessionsCompleted: Int)
}

class FocusViewController: UIViewController {

    let imageName: [String] = ["pause.circle", "play.circle"]
    var completionDelegate: CompletionDelegate?
    var newActivity: Activity?
    let defaults = UserDefaults.standard
    var timerArray: [Timer] = []
    var focusComplete = false
    var breakComplete = false
    var sessionComplete = false
    var currentSession = 1
    var pos = 0
    var timeLeft: Int?
    var totalTime: Int?
    var breakTimeLeft: Int?
    var breakTotalTime: Int?
    var activityName: String?
    var sessionNumber: String?
    var timer = Timer()
    var breakTimer = Timer()
    @IBOutlet weak var pauseImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var timerImage: UIImageView!
    @IBOutlet weak var mainTimer: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var sessionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        activityLabel.text = "\(activityName!)"
        sessionLabel.text = "Session: \(currentSession) out of \(sessionNumber!)"
        focusScreen()
        pauseImage.image = UIImage(systemName: imageName[0])
       // focusCountdownTimer()
    }

    @IBAction func pauseButton(_ sender: UIButton) {
        if pos == 0 {
            pauseImage.image = UIImage(systemName: imageName[1])
            pos = 1
            timer.invalidate()
            breakTimer.invalidate()
        } else if pos == 1 {
            pauseImage.image = UIImage(systemName: imageName[0])
            pos = 0
            focusComplete ? breakCountdownTimer() : focusCountdownTimer()
        }
    }

    @IBAction func cancelButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

    func focusScreen() {
        timeLeft = defaults.integer(forKey: "FocusSetting")
        timerImage.image = UIImage(named: "tomato")
        sessionLabel.text = "Session: \(currentSession) out of \(sessionNumber!)"
        progressBar.progress = 1.0
        progressBar.progressTintColor = UIColor(red: 0.78, green: 0.10, blue: 0.07, alpha: 1.00)
        pauseImage.tintColor = UIColor(red: 0.78, green: 0.10, blue: 0.07, alpha: 1.00)
        mainTimer.text = timeFormatted(totalTime!)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(focusUpdateTimer), userInfo: nil, repeats: true)
    }

    func breakScreen() {
        breakTimeLeft = defaults.integer(forKey: "BreakSetting")
        timerImage.image = UIImage(named: "cucumber")
        sessionLabel.text = "Session: \(currentSession) out of \(sessionNumber!)"
        progressBar.progress = 1.0
        progressBar.progressTintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
        pauseImage.tintColor = UIColor(red: 0.00, green: 0.55, blue: 0.01, alpha: 1.00)
        mainTimer.text = timeFormatted(breakTotalTime!)
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakUpdateTimer), userInfo: nil, repeats: true)
    }

    /// Function to format the time text
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }



    func focusCountdownTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(focusUpdateTimer), userInfo: nil, repeats: true)
    }

    @objc func focusUpdateTimer() {
           if timeLeft != 0 {
               timeLeft! -= 1
               mainTimer.text = timeFormatted(timeLeft!)
               progressBar.progress = Float(timeLeft!) / Float(totalTime!)
           } else {
               focusComplete = true
               timer.invalidate()
               breakScreen()
           }
    }

    func resetFocusTimer() {
        timer.invalidate()
        focusCountdownTimer()
    }

    func breakCountdownTimer() {
        breakTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(breakUpdateTimer), userInfo: nil, repeats: true)
    }

    @objc func breakUpdateTimer() {
        if breakTimeLeft != 0 {
            breakTimeLeft! -= 1
            mainTimer.text = timeFormatted(breakTimeLeft!)
            progressBar.progress = Float(breakTimeLeft!) / Float(breakTotalTime!)
        } else {
            breakComplete = true
            breakTimer.invalidate()
            checkCurrentSession()
        }
    }

    func checkCurrentSession() {
        let totalSession = Int(sessionNumber!)

        if currentSession == totalSession {

            completionDelegate?.didCompleteSession(activityName: activityName!, sessionsCompleted: Int(sessionNumber!)!)

            guard let navVC = tabBarController?.viewControllers?[0] else {
                print("view controller is nil")
                return
            }

            let uiNav = navVC as! UINavigationController

            let historyController = uiNav.topViewController as! HistoryViewController

            if let name = activityName, let session = sessionNumber {
                newActivity = Activity(name: name, session: Int(session) ?? 0)
            }

            historyController.newActivity = newActivity

//            let navVC = tabBarController?.viewControllers![0] as! UINavigationController
//
//            let historyTabController = navVC.topViewController as! HistoryViewController
//
//            let newActivity = Activity(name: activityName!, session: Int(sessionNumber!)!)
//
//            historyTabController.newActivity = newActivity

            let alert = UIAlertController(title: "Congrats!", message: "You have completed all the sessions.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: nil)
                }))
            self.present(alert, animated: true, completion: nil)

        } else {
            currentSession += 1
            focusComplete = false
            breakComplete = false
            focusScreen()
        }
    }

}
