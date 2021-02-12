//
//  DataStorage.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 9/2/21.
//  Copyright © 2021 Franco Buena. All rights reserved.
//

import Foundation

struct DataStorage: Codable {
    
    let activityHistoryURL: URL
    
    enum DataError: Error {
        case dataNotFound
        case dataNotSaved
    }
    
    init() {
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        activityHistoryURL = documentsDirectory.appendingPathComponent("activity_history").appendingPathExtension("json")
        
    }
    
    
    func write(_ data: Data, to archive: URL) throws {
        do {
            try data.write(to: archive, options: .noFileProtection)
        } catch {
            throw DataError.dataNotSaved
        }
    }
    
    func read(from archive: URL) throws -> Data {
        if let data = try? Data(contentsOf: archive) {
            return data
        }
        throw DataError.dataNotFound
    }
    
    func saveData(activity: [Activity]) throws {
        let data = try JSONEncoder().encode(activity)
        try write(data, to: activityHistoryURL)
    }
    
    func loadActivity() throws -> [Activity] {
        let data = try read(from: activityHistoryURL)
        if let history = try? JSONDecoder().decode([Activity].self, from: data) {
            return history
        }
        throw DataError.dataNotFound
    }
    
}
