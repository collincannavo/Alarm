//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Collin Cannavo on 5/29/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    
   // MARK: Actions
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        guard let title = textField.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight
            else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidnight)
        
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            cancelUserNotifications(for: alarm)
            scheduleUserNotifications(for: alarm)
            
        } else {
          let alarm = AlarmController.shared.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleUserNotifications(for: alarm)
        }
        
      let _ = navigationController?.popViewController(animated: true)
    }
   
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.shared.toggleEnabled(for: alarm)
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
            
        } else {
            cancelUserNotifications(for: alarm)
        }
        updateViews()
        
    }
    // MARK: - Actions
    
    private func updateViews() {
        guard let alarm = alarm, let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight, isViewLoaded else {
            enableButton.isHidden = false
            return
        }
        
    datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
   
    textField.text = alarm.name
    
    enableButton.isHidden = true
        if alarm.enabled {
            enableButton.setTitle("Disable", for: UIControlState())
            enableButton.setTitleColor(.white, for: UIControlState())
            enableButton.backgroundColor = .red
        } else {
            enableButton.setTitle("Enable", for: UIControlState())
            enableButton.setTitleColor(.white, for: UIControlState())
            enableButton.backgroundColor = .gray
        }
    
    self.title = alarm.name
    
    }
    
    // MARK: Properties
    
    
    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
            updateViews()
            }
        }
    }

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var enableButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
}
