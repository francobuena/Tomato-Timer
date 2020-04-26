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
    
    var focusArray: [Int] = []
    var breakArray: [Int] = []
    
    init() {
        for number in 1...25 {
            focusArray.append(number)
        }
        focusArray.reverse()
        
        for number in 1...5 {
            breakArray.append(number)
        }
        breakArray.reverse()
    }
    
    func getFocusTime(as minutes: Int) {

    }
    
    func getBreakTime(as minutes: Int) {

    }
}
