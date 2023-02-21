//
//  TrackedItemsView.swift
//  iExpire
//
//  Created by Andy Wu on 1/20/23.
//

import SwiftUI
import OrderedCollections

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
     
    var itemsGroupedByCategory: OrderedDictionary<String, [(Item, Int)]> {
        // Extra Int is for onDelete to properly delete correct Item
        var groupedItems: OrderedDictionary<String, [(Item, Int)]> = [:]
        for i in 0..<items.count {
            let item = items[i]
            if let _ = groupedItems[item.wrappedCategory] {
                groupedItems[item.wrappedCategory]!.append((item, i))
            } else {
                groupedItems[item.wrappedCategory] = [(item, i)]
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
                    // Section
                    ForEach(itemsGroupedByCategory.keys, id: \.self) { section in
                        Section {
                            ForEach(itemsGroupedByCategory[section]!, id: \.0) { item in
                                NavigationLink {
                                    ItemDetailView(item: item.0)
                                } label: {
                                    ListItem(item: item.0)
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                    Button(role: .destructive) {
                                        delete(at: IndexSet(integer: item.1))
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                            }
                        } header: {
                            Text(section)
                                .accessibilityLabel("\(section) category")
                        }
                    }
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
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(item.wrappedName) expires on \(item.wrappedExpiration)")
        }
    }
}
