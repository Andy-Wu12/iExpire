//
//  CoreDataUtil.swift
//  iExpire
//
//  Created by Andy Wu on 1/26/23.
//

import CoreData
import SwiftUI
import OrderedCollections

func clearEntityRecords(managedObjectContext moc: NSManagedObjectContext, entityName: String, predicate: NSPredicate? = nil) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    fetchRequest.predicate = predicate
    
    let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    batchDeleteRequest.resultType = NSBatchDeleteRequestResultType.resultTypeObjectIDs
    
    do {
        let result = try moc.execute(batchDeleteRequest) as? NSBatchDeleteResult
        let objectIDArray = result?.result as? [NSManagedObjectID]
        
        let changes = [NSDeletedObjectsKey : objectIDArray]
        
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes as [AnyHashable : Any], into: [moc])
    } catch {
        // Handle errors
        fatalError("Failed to perform batch delete: \(error)")
    }
}

func groupElementsByProperty<T, V: CustomStringConvertible>(_ items: any Sequence<T>, property: KeyPath<T, V>) -> OrderedDictionary<V, [T]> {
    OrderedDictionary(grouping: items, by: { $0[keyPath: property] })
}
