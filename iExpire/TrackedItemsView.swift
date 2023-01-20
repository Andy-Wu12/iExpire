//
//  TrackedItemsView.swift
//  iExpire
//
//  Created by Andy Wu on 1/20/23.
//

import SwiftUI
import CoreData

struct TrackedItemsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            VStack {
                List(items, id: \.self) { item in
                    HStack {
                        Text(item.wrappedName)
                        Spacer()
                        Text(item.expirationDate?.formatted(.dateTime.day().month().year()) ?? "Unknown expiration")
                    }
                }
            }
            .navigationTitle("Tracked Items")
        }
    }
}

struct TrackedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        TrackedItemsView()
    }
}
