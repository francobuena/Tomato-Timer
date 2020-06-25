//
//  ViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 9/4/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var focusTime: Int?
    var breakTime: Int?
    var freshLaunch = true
    let timeManager = TimeManager()
    let defaults = UserDefaults.standard
    @IBOutlet weak var activityName: UITextField!
    @IBOutlet weak var sessionNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
    }

    
    @IBAction func beginButton(_ sender: Any) {
        if activityName.text == "" || sessionNumber.text == "" {
            let alert = UIAlertController(title: "Error", message: "Fill in all the information.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.performSegue(withIdentifier: "goToTimer", sender: self)
        }
        print(defaults.integer(forKey: "FocusSetting"))
        print(defaults.integer(forKey: "BreakSetting"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTimer" {
            let destinationVC = segue.destination as! FocusViewController
            destinationVC.activityName = activityName.text
            destinationVC.sessionNumber = sessionNumber.text
            destinationVC.timeLeft = defaults.integer(forKey: "FocusSetting")
            destinationVC.totalTime = defaults.integer(forKey: "FocusSetting")
            destinationVC.breakTimeLeft = defaults.integer(forKey: "BreakSetting")
            destinationVC.breakTotalTime = defaults.integer(forKey: "BreakSetting")
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwindToMain", sender: self)
    }

}

