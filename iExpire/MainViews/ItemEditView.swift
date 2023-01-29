//
//  ItemEditView.swift
//  iExpire
//
//  Created by Andy Wu on 1/28/23.
//

import SwiftUI

struct ItemEditView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
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
                    item.name = name
                    item.notes = notes
                    try? moc.save()
                    dismiss()
                }
                .disabled(name.isEmpty)
            }
            .navigationTitle("Edit Item")
        }
    }
    
}
