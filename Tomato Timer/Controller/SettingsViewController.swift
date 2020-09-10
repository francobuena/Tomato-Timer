//
//  SettingsViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 19/6/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITabBarControllerDelegate {

    let timeManager = TimeManager()
    var conversion = ConversionBrain()
    var focusMin = 0
    var focusSec = 0
    var breakMin = 0
    var breakSec = 0
    let defaults = UserDefaults.standard
    @IBOutlet weak var focusMinute: UIPickerView!
    @IBOutlet weak var focusSecond: UIPickerView!
    @IBOutlet weak var breakMinute: UIPickerView!
    @IBOutlet weak var breakSecond: UIPickerView!


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case focusMinute:
            return timeManager.focusMin.count
        case focusSecond:
            return timeManager.focusSec.count
        case breakMinute:
            return timeManager.breakMin.count
        case breakSecond:
            return timeManager.breakSec.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case focusMinute:
            return String(timeManager.focusMin[row])
        case focusSecond:
            return String(timeManager.focusSec[row])
        case breakMinute:
            return String(timeManager.breakMin[row])
        case breakSecond:
            return String(timeManager.breakSec[row])
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case focusMinute:
            let selectedFM = timeManager.focusMin[row]
            focusMin = selectedFM
            print(focusMin)
        case focusSecond:
            let selectedFS = timeManager.focusSec[row]
            focusSec = selectedFS
            print(focusSec)
        case breakMinute:
            let selectedBM = timeManager.breakMin[row]
            breakMin = selectedBM
            print(breakMin)
        case breakSecond:
            let selectedBS = timeManager.focusSec[row]
            breakSec = selectedBS
            print(breakSec)
        default:
            print("Nice")
        }

        let focusSetting = conversion.convertToSeconds(minutes: focusMin, seconds: focusSec)
        let breakSetting = conversion.convertToSeconds(minutes: breakMin, seconds: breakSec)

        defaults.set(focusSetting, forKey: "FocusSetting")
        defaults.set(breakSetting, forKey: "BreakSetting")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        focusMinute.dataSource = self
        focusMinute.delegate = self
        focusSecond.dataSource = self
        focusSecond.delegate = self
        breakMinute.dataSource = self
        breakMinute.delegate = self
        breakSecond.dataSource = self
        breakSecond.delegate = self

        self.tabBarController?.delegate = self


    }


    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: SettingsViewController.self as AnyClass) {
            let viewController = tabBarController.viewControllers?[1] as! MainViewController
            let totalFocusSeconds = (focusMin * 60) + focusSec
            viewController.focusTime = totalFocusSeconds
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
