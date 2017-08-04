//
//  AlarmListTableViewController.swift
//  Alarm
//
//  Created by Collin Cannavo on 5/29/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return AlarmController.shared.alarms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell ?? SwitchTableViewCell()
        
        cell.alarm = AlarmController.shared.alarms[indexPath.row]
        
        
        return cell
    }
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
      
        let alarm = AlarmController.shared.alarms[indexPath.row]
      
        AlarmController.shared.toggleEnabled(for: alarm)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    /*
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     
        return true
    }
    */

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alarm = AlarmController.shared.alarms[indexPath.row]
            AlarmController.shared.delete(alarm: alarm)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    

    /*
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     
        return true
    }
    */

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetail" {
            guard let detailVC = segue.destination as? AlarmDetailTableViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            detailVC.alarm = AlarmController.shared.alarms[indexPath.row]
        }
    }


}














