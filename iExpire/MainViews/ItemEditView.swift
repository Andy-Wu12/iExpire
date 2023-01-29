//
//  ItemEditView.swift
//  iExpire
//
//  Created by Andy Wu on 1/28/23.
//

import SwiftUI

struct ItemEditView: View {
    @ObservedObject var item: Item
    
    @State private var name = ""
    @State private var notes = ""
    
    init(item: Item, _ name: String = "", _ notes: String = "") {
        self.item = item
        
//    https://docs.swift.org/swift-book/ReferenceManual/Attributes.html - "propertyWrapper"
        _name = State(initialValue: item.wrappedName)
        _notes = State(initialValue: item.wrappedNotes)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name", text: $name)
                } header: {
                    Text("Name")
                }
                
                Section {
                    TextEditor(text: $notes)
                } header: {
                    Text("Notes")
                }
                
                Button("Save") {
                    // Saving changes here

                }
            }
            .navigationTitle("Edit Item")
        }
        .multilineTextAlignment(.center)
    }
}
