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

    @NSManaged public var expirationDate: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var expirationMonth: Int32
    @NSManaged public var expirationDay: Int32
    @NSManaged public var expirationYear: Int32

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
        
        var components = DateComponents()
        components.month = Int(expirationMonth)
        components.day = Int(expirationDay)
        components.year = Int(expirationYear)
        
        return Calendar.current.date(from: components)!
    }
}

extension Item : Identifiable {

}
