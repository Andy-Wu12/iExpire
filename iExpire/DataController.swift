//
//  DataController.swift
//  iExpire
//
//  Created by Andy Wu on 1/19/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    // Responsible for loading data model
    let container = NSPersistentContainer(name: "iExpireProject")
    
    init() {
        // Load data model and handle potential errors
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
                return
            }
            
            // Merge duplicate objects based on their properties
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        }
    }
}
