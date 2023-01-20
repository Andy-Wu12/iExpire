//
//  AddExpirationView.swift
//  iExpire
//
//  Created by Andy Wu on 1/19/23.
//

import SwiftUI

struct AddExpirationView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    @State private var expDate = Date()
    
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
                    
                    Button("Create") {
                        saveItem()
                    }
                }
                .navigationTitle("Add Item")
            }
        }
    }
    
    func saveItem() {
        let newItem = Item(context: moc)
        newItem.name = name
        newItem.expirationDate = expDate
        
        try? moc.save()
    }
}

struct AddExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpirationView()
    }
}
