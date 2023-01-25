//
//  NotificationPermission.swift
//  iExpire
//
//  Created by Andy Wu on 1/24/23.
//

import SwiftUI
import UserNotifications

struct NotificationPermission: View {
    @State private var notificationsOn = false
    var body: some View {
        Toggle("Allow Notifications", isOn: $notificationsOn)
            .onChange(of: notificationsOn) { value in
                if notificationsOn {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                    { success, error in
                        if success {
                            print("Permission granted!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
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
