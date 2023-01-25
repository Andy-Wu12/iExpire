//
//  SettingsView.swift
//  iExpire
//
//  Created by Andy Wu on 1/24/23.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    
    var body: some View {
        List {
            Section {
                Text("Toggle Notifications")
            } header: {
                Text("App Permissions")
            }
            
            Section {
                ExportToCSVButton()
            } header: {
                Text("Your Data")
            }
            
            Section {
                Text("Test lockscreen notifications here")
            } header: {
                Text("Testing")
            }
            
            Section {
                ResetDataButton()
            }
        }
    }
}

struct ResetDataButton: View {
    let sfImage = "eraser.line.dashed.fill"
    
    var body: some View {
        ButtonWithIconLeft("Clear all app data", image: Image(systemName: sfImage), role: .destructive) {
            // action code here
        }
    }
}

struct ExportToCSVButton: View {
    let sfImage = "square.and.arrow.down.fill"
    
    var body: some View {
        ButtonWithIconLeft("Export Item Data (CSV)", image: Image(systemName: sfImage)) {
            // action code here
        }
    }
}

struct ButtonWithIconLeft: View {
    var text: String
    var image: Image
    var role: ButtonRole?
    var action: () -> Void
    
    init(_ text: String, image: Image, role: ButtonRole? = nil, action: @escaping () -> Void) {
        self.text = text
        self.image = image
        self.role = role
        self.action = action
    }
    
    var body: some View {
        HStack {
            image
            Button(text, role: role) {
                action()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
