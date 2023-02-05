//
//  TrackedItemsView.swift
//  iExpire
//
//  Created by Andy Wu on 1/20/23.
//

import SwiftUI

struct TrackedItemsView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.expirationDateTime),
        SortDescriptor(\.name)
    ]) var items: FetchedResults<Item>
    
    @State private var showingAddScreen = false
    @State private var showingSettings = false
    @State private var showingDeleteAlert = false
    
    var categories: Set<String> {
        var uniqueCategories = Set<String>()
        items.forEach() { item in
            uniqueCategories.insert(item.wrappedCategory)
        }
        return uniqueCategories
    }
    
    var itemsGroupedByCategory: Dictionary<String, [Item]> {
        var groupedItems: Dictionary<String, [Item]> = [:]
        items.forEach() { item in
            if let _ = groupedItems[item.wrappedCategory] {
                groupedItems[item.wrappedCategory]!.append(item)
            } else {
                groupedItems[item.wrappedCategory] = [item]
            }
        }
        
        return groupedItems
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Delete EXPIRED") {
                    showingDeleteAlert.toggle()
                }
                .alert("This action is IRREVERSIBLE", isPresented: $showingDeleteAlert) {
                    Button("Cancel", role: .cancel) {
                        showingDeleteAlert.toggle()
                    }
                    Button("OK", role: .destructive) {
                        clearEntityRecords(managedObjectContext: moc, entityName: "Item",
                                           predicate: NSPredicate(format: "expirationDateTime < %@", createDateAtMidnight(date: Date.now) as CVarArg))
                    }
                }
                List {
                    ForEach(items, id: \.self) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            ListItem(item: item)
                        }
                    }
                    .onDelete(perform: delete)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Tracked Items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddExpirationView(categories: categories.sorted())
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(items: items)
            }
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            // Only delete notification if expirationDate is unique
            let sameExpirationItems = items.filter { $0.wrappedExpiration == item.wrappedExpiration }
            if sameExpirationItems.count == 1 {
                removeSpecificNotifications(for: [item.wrappedExpiration])
            }
            moc.delete(item)
        }
        
        try? moc.save()
    }
    
}

struct TrackedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedItemsView()
    }
}

struct ListItem: View {
    var item: Item
    
    var body: some View {
        VStack {
            HStack {
                Text(item.wrappedName)
                    .padding()
                Spacer()
                ExpirationTextView(expirationDate: item.wrappedDateTime)
                    .padding()
            }
        }
    }
}
