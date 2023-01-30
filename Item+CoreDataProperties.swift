//
//  Item+CoreDataProperties.swift
//  iExpire
//
//  Created by Andy Wu on 1/19/23.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var expirationDate: String?
    @NSManaged public var notes: String?
    @NSManaged public var image: Data?

    public var wrappedName: String {
        name ?? "Unknown name"
    }

    public var wrappedExpiration: String {
        expirationDate ?? "Unknown expiration"
    }
    
    public var wrappedNotes: String {
        notes ?? ""
    }
    
    public var expirationToDate: Date {
        let dateNoCommas = expirationDate!.filter { $0 != "," }
        let splitComponents = dateNoCommas.split(separator: " ")
        
        var components = DateComponents()
        components.month = monthIntDict[String(splitComponents[0])]
        components.day = Int(String(splitComponents[1])) ?? 0
        components.year = Int(String(splitComponents[2])) ?? 0
        
        return Calendar.current.date(from: components)!
    }
}

extension Item : Identifiable {

}
