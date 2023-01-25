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
        Button("Manage Notification Settings") {
            if !requestedPermission {
                UserDefaults.standard.set(true, forKey: "notifications")
                requestedPermission = true
            
            // Notifications can only be requested when app is opened for first time after installation
               UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
               { success, error in
                   if success {
                       print("Permission granted!")
                   } else if let error = error {
                       print(error.localizedDescription)
                   }
               }
            } else {
                // Handle already denied permission by opening phone's settings page for app
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
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
