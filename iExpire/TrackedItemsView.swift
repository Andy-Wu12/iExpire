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
    
    var body: some View {
        NavigationView {
            VStack {
                List(items, id: \.self) { item in
                    VStack {
                        HStack {
                            Text(item.wrappedName)
                            Spacer()
                            Text(item.wrappedExpiration)
                        }
                    }
                }
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
            }
            .sheet(isPresented: $showingAddScreen) {
                AddExpirationView()
            }
        }
    }
}

struct TrackedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedItemsView()
    }
}
