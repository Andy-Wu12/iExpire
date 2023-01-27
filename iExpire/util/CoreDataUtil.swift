//
//  CoreDataUtil.swift
//  iExpire
//
//  Created by Andy Wu on 1/26/23.
//

import CoreData
import SwiftUI

func clearEntityRecords(managedObjectContext moc: NSManagedObjectContext ,entityName: String) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
        try moc.execute(batchDeleteRequest)
    } catch {
        // Handle errors
    }
}
