//
//  ConversionBrain.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 23/6/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import Foundation

struct ConversionBrain {
    
    mutating func convertToSeconds(minutes: Int, seconds: Int) -> Int {
        let secondsResult = (minutes * 60) + seconds
        return secondsResult
    }
    
    
}
