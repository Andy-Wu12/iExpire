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
            ScrollView(.vertical) {
                LazyVStack(spacing: 10) {
                    ForEach(items, id: \.self) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            ListItem(item: item)
                        }
                        .background(Color("UniversalPurple"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding([.leading, .trailing])
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
                Text(item.wrappedExpiration)
                    .padding()
            }
        }
    }
}
