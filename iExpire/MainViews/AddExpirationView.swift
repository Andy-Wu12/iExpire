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
        
        try? moc.save()
        dismiss()
    }
}

struct AddExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpirationView()
    }
}
