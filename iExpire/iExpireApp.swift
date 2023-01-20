//
//  iExpireApp.swift
//  iExpire
//
//  Created by Andy Wu on 1/19/23.
//

import SwiftUI

@main
struct iExpireApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            TrackedItemsView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
