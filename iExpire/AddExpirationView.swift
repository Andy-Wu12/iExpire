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
    @State private var expDate = Date()
    @State private var image: PhotosPickerItem? = nil
    
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
                    }
                    Section {
                        DatePicker(selection: $expDate, displayedComponents: [.date]) {}
                            .labelsHidden()
                        
                    } header: {
                        Text("Expiration Date")
                    }
                    
                    Section {
                        PhotosPicker(
                            selection: $image,
                            matching: .images, photoLibrary: .shared()
                        )
                        {
                            Text("Select")
                        }
                    } header: {
                        Text("Photo of item")
                    }
                        
                    Button("Create") {
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
        print(expDate.formatted(.dateTime.day().month().year()))
        newItem.expirationDate = expDate.formatted(.dateTime.day().month().year())
        
        try? moc.save()
        dismiss()
    }
}

struct AddExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpirationView()
    }
}
