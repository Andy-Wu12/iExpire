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
        SortDescriptor(\.expirationDate),
        SortDescriptor(\.name)
    ]) var items: FetchedResults<Item>
    
    @State private var showingAddScreen = false
    @State private var showingSettings = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink {
                        ItemDetailView(item: item)
                    } label: {
                        ListItem(item: item)
                    }
//                    .background(Color("UniversalPurple"))
//                    .foregroundColor(.white)
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
//                    .padding([.leading, .trailing])
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
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
                AddExpirationView()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
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
                ExpirationTextView(expirationDate: item.wrappedExpiration)
                    .padding()
            }
        }
    }
}
