//
//  TimeManager.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 9/4/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import Foundation

// struct that holds the values of the picker view
struct TimeManager {
    
    var focusMin: [Int] = []
    var focusSec: [Int] = []
    var breakMin: [Int] = []
    var breakSec: [Int] = []
    
    init() {
        for number in 0...60 {
            focusMin.append(number)
        }
        
        for number in 0...60 {
            focusSec.append(number)
        }
        
        for number in 0...60 {
            breakMin.append(number)
        }
        
        for number in 0...60 {
            breakSec.append(number)
        }
    }
}
