//
//  NotificationPermission.swift
//  iExpire
//
//  Created by Andy Wu on 1/24/23.
//

import SwiftUI
import UserNotifications

struct NotificationPermission: View {
    @State private var requestedPermission = UserDefaults.standard.bool(forKey: "notifications")
    @State private var notificationsOn = UIApplication.shared.isRegisteredForRemoteNotifications
    
    var body: some View {
        Toggle("Allow Notifications", isOn: $notificationsOn)
            // Get old value of toggle with [notificationsOn]
            .onChange(of: notificationsOn) { [notificationsOn] _ in
                if !requestedPermission {
                    UserDefaults.standard.set(true, forKey: "notifications")
                    requestedPermission = true
                    
                // Notifications can only be requested when app is opened for first time after installation
                   UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                   { success, error in
                       if success {
                           print("Permission granted!")
                       } else {
                           self.notificationsOn = false
                       }
                   }
                } else {
                    // Handle already denied permission by opening phone's settings page for app
                    if !notificationsOn {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        self.notificationsOn = false
                    } else {
                        // Remove notification permission / all scheduled notifications
                    }
                }
            }
    }
}

struct NotificationPermissions_Previews: PreviewProvider {
    static var previews: some View {
        List {
            NotificationPermission()
        }
    }
}
