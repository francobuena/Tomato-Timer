//
//  ViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 9/4/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var focusMinute = 25
    var breakMinute = 5
    let timeManager = TimeManager()
    
    // determines the number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // function that determines the number of components in picker view. also contains an if statement that allows two picker views to exist in one UI
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == focusTimerPicker {
            return timeManager.focusArray.count
        } else {
            return timeManager.breakArray.count
        }
    }
    
    // loads the contents of picker view from the struct. also distinguishes between the two pickerviews
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == focusTimerPicker {
            return String(timeManager.focusArray[row])
        } else {
            return String(timeManager.breakArray[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == focusTimerPicker {
            let selectedFocus = timeManager.focusArray[row]
            
            
            //timeManager.getFocusTime(as: selectedFocus)
            focusMinute = selectedFocus
            print(focusMinute)
        } else {
            let selectedBreak = timeManager.breakArray[row]
            breakMinute = selectedBreak
            print(breakMinute)
        }
    }
    
    @IBOutlet weak var focusTimerPicker: UIPickerView!
    @IBOutlet weak var breakTimerPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        focusTimerPicker.dataSource = self
        focusTimerPicker.delegate = self
        breakTimerPicker.dataSource = self
        breakTimerPicker.delegate = self
    }
    
    @IBAction func beginButton(_ sender: Any) {
        //let focusVC = FocusController()
        //focusVC.focusValue = minute
        self.performSegue(withIdentifier: "goToTimer", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTimer" {
            let destinationVC = segue.destination as! FocusViewController
            destinationVC.focusValue = focusMinute
            destinationVC.breakValue = breakMinute
        }
    }

}

