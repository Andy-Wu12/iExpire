//
//  AddExpirationView.swift
//  iExpire
//
//  Created by Andy Wu on 1/19/23.
//

import SwiftUI
import PhotosUI

struct AddExpirationView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var notes = ""
    @State private var expDate = Date()
    @State private var image: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    
    func isValidItem() -> Bool {
        !(name.isEmpty)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Item name", text: $name)
                            .autocorrectionDisabled()
                        DatePicker("Expires:", selection: $expDate, displayedComponents: [.date])
                    } header: {
                        Text("Required")
                    }
                    
                    Section {
                        TextEditor(text: $notes)
                        PhotoSelectorView(selectedItem: $image, imageData: $imageData)
                    } header: {
                        Text("Optional notes and photo")
                    }
                    
                    Button("Submit") {
                        saveItem()
                    }
                    .disabled(!isValidItem())
                }
                .navigationTitle("Add Item")
            }
        }
    }
    
    func saveItem() {
        let newItem = Item(context: moc)
        newItem.name = name
        newItem.expirationDate = dateToFormatString(date: expDate)
        newItem.image = imageData
        newItem.notes = notes
        newItem.expirationDateTime = createDateAtMidnight(date: expDate)
        
        do {
            try moc.save()
            scheduleItemNotification(for: newItem.wrappedExpiration, on: expDate)
        } catch {
            // TODO: Should throw, handle error, and show error in view somewhere
            return
        }
        
        dismiss()
    }
    
    // Notifications should be keyed by Item.wrappedExpiration
    func scheduleItemNotification(for id: String, on date: Date) {
        let title = "EXPIRATION"
        let subtitle = "You have items expiring TODAY (\(id))!"
        let delay: Double = Date.now.distance(to: date)
        
        if delay <= 0 {
            return
        }
        
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests() { notifications in
            for notification in notifications {
                // If notification already exists for date, do nothing
                if notification.identifier == id {
                    return
                }
            }
            
            scheduleNotification(title: title, subtitle: subtitle, secondsFromNow: delay, identifier: id)
        }
    }
}

struct AddExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpirationView()
    }
}
