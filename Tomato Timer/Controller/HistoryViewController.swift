//
//  HistoryViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 29/6/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController, UITabBarControllerDelegate {

    var activityName: String?
    var totalSessions: Int?
    
    var newActivity: Activity?

    var history = [Activity]()
    
    let dataStorage = DataStorage()

    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            history = try dataStorage.loadActivity()
        } catch {
            print("Error loading history")
        }
        
        sortHistory()
        
        if let activity = activityName, let total = totalSessions {
            
            let newActivity = Activity(name: activity, session: total)
            
            history.append(newActivity)
            sortHistory()
            tableView.reloadData()
            
            do {
                try dataStorage.saveData(activity: history)
            } catch {
                print("Error saving history")
            }
        }
        
        print(dataStorage.activityHistoryURL)

    }
    
    func sortHistory() {
        history.reverse()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActivityCustomCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCustomCell

        cell.cellActivity.text = history[indexPath.row].name
        cell.cellSession.text = String(history[indexPath.row].session) + " sessions"

        return cell
    }

}
