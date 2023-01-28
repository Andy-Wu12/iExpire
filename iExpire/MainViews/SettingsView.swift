//
//  SettingsView.swift
//  iExpire
//
//  Created by Andy Wu on 1/24/23.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
    var items: FetchedResults<Item>
    
    var body: some View {
        List {
            Section {
                NotificationPermission()
            } header: {
                Text("App Permissions")
            }
            
            Section {
                ExportToCSVButton(items: items)
            } header: {
                Text("Your Data")
            }
            
            Section {
                TestNotificationButton()
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
    @Environment(\.managedObjectContext) var moc
    @State private var showingAlert = false
    
    let sfImage = "eraser.line.dashed.fill"
    
    var body: some View {
        ButtonWithIconLeft("Clear all app data", image: Image(systemName: sfImage), role: .destructive) {
                showingAlert = true
        }
        .alert("This is an IRREVERSIBLE action!", isPresented: $showingAlert) {
            Button("OK", role: .destructive) {
                clearEntityRecords(managedObjectContext: moc, entityName: "Item")
                removeAllNotifications()
            }
            Button("Cancel", role: .cancel) {
                showingAlert = false
            }
        }
    }
    
}

struct ExportToCSVButton: View {
    @Environment(\.managedObjectContext) var moc
    var items: FetchedResults<Item>
    
    @State private var csvDoc: CSVDocument = CSVDocument(initialText: "")
    @State private var isExporting = false
    
    private let filename = "items.csv"
    private let sfImage = "square.and.arrow.down.fill"
    
    var body: some View {
        ButtonWithIconLeft("Export Item Data (CSV)", image: Image(systemName: sfImage)) {
            createCSVData()
            isExporting = true
        }
        .fileExporter(isPresented: $isExporting, document: csvDoc,
                      contentType: .commaSeparatedText, defaultFilename: filename) { result in
            switch result {
            case .success(let url):
                print("Saved to \(url)")
            case .failure(let error):
                print(error.localizedDescription)
            }
            isExporting = false
        }
        
    }
    
    func createCSVData() {
        var csvString = "\("Name"),\("ExpirationDate")\n\n"
        
        items.forEach { item in
            csvString = csvString.appending("\"\(item.wrappedName)\",\"\(item.wrappedExpiration)\"\n")
        }
        
        csvDoc.text = csvString
    }
}

struct TestNotificationButton: View {
    var body: some View {
        Button("Schedule Notification") {
            scheduleNotification(
                title: "EXPIRATION",
                subtitle: "You have an item that expires soon",
                secondsFromNow: 5,
                identifier: UUID().uuidString
            )
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
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.expirationDate),
        SortDescriptor(\.name)
    ]) static var items: FetchedResults<Item>
    
    static var previews: some View {
        SettingsView(items: items)
    }
}
