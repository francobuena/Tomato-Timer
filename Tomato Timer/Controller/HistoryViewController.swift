//
//  HistoryViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 29/6/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController, UITabBarControllerDelegate {

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    var newActivity: Activity?

    var activity = [Activity]()

    override func viewDidLoad() {
        super.viewDidLoad()

        //print(dataFilePath!)

    }

    override func viewWillAppear(_ animated: Bool) {
        if newActivity != nil {
            activity.append(newActivity!)
        }

        saveActivity()

    }

    override func viewWillDisappear(_ animated: Bool) {
        newActivity = nil
    }

    func saveActivity() {
        let encoder = PropertyListEncoder()

        do {
            let data = try encoder.encode(activity)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }

        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activity.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActivityCustomCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCustomCell

        cell.cellActivity.text = activity[indexPath.row].name
        cell.cellSession.text = String(activity[indexPath.row].session) + " sessions"

        return cell
    }

}
