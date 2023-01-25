//
//  Notifications.swift
//  iExpire
//
//  Created by Andy Wu on 1/24/23.
//

import Foundation
import UserNotifications

func scheduleNotification(title: String, subtitle: String, secondsFromNow: Double, identifier: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: secondsFromNow, repeats: false)
    
    let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
    
    UNUserNotificationCenter.current().add(request)
}

func removeSpecificNotifications(for ids: [String]) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
}

func removeAllNotifications() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
}
