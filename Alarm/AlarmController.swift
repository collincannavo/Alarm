//
//  AlarmController.swift
//  Alarm
//
//  Created by Collin Cannavo on 5/29/17.
//  Copyright © 2017 Collin Cannavo. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmController{
    
    static let shared = AlarmController()
    
   
    var alarms: [Alarm] = []
   
   init() {
    
    self.alarms = self.mockAlarms
    
    }
   
    var mockAlarms:[Alarm] {
        let clock1 = Alarm(fireTimeFromMidnight: 1, name: "Collin")
        let clock2 = Alarm(fireTimeFromMidnight: 23, name: "DevMtn")
       let clock3 = Alarm(fireTimeFromMidnight: 2554, name: "Awesome")
   
        return [clock1, clock2, clock3]
    }
    
    func addAlarm(fireTimeFromMidnight:  TimeInterval, name: String) -> Alarm  {
        var alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        
        alarms.append(alarm)
        
        return alarm
        
    }
    func update(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.index(of: alarm) else { return }
        alarms.remove(at: index)
        
    }
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        
    }
    
    static private var persistentAlarmsFilePath: String? {
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
    guard let documentsDirectory = directories.first as NSString? else { return nil }
    return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
    
    private func saveToPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filePath)
    }
    
    private func loadFromPersistentStorage() {
        guard let filePath = type(of: self).persistentAlarmsFilePath else { return }
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Alarm] else { return }
        self.alarms = alarms
    }
    
    
}

// MARK: AlarmScheduler

protocol AlarmScheduler {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Your Alarm"
        notificationContent.body = "Your Alarm Body Text"
        notificationContent.sound = UNNotificationSound.default()
      
        let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
       
        let requests = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(requests) { (error) in
            if let error = error {
                print("This is an error: I can't add the notification")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
        
    }
    
}















