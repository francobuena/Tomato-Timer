//
//  HistoryViewController.swift
//  Tomato Timer
//
//  Created by Franco  Buena on 29/6/20.
//  Copyright © 2020 Franco Buena. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {

    var activityArray = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newActivity = Activity()
        newActivity.name = "Coding"
        newActivity.session = 4
        activityArray.append(newActivity)
        
        let newActivity1 = Activity()
        newActivity1.name = "Read"
        newActivity1.session = 2
        activityArray.append(newActivity1)
        
        let newActivity2 = Activity()
        newActivity2.name = "Raving"
        newActivity2.session = 2
        activityArray.append(newActivity2)
        
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activityArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActivityCustomCell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCustomCell

        cell.cellActivity.text = activityArray[indexPath.row].name
        cell.cellSession.text = String(activityArray[indexPath.row].session) + " sessions"
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
