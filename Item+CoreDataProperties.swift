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
    // Images can be converted to binary data using something like
    // image.jpegData(compressionQuality: 1.0)
    @NSManaged public var image: Data?

    public var wrappedName: String {
        name ?? "Unknown name"
    }

    public var wrappedExpiration: String {
        expirationDate ?? "Unknown expiration"
    }
}

extension Item : Identifiable {

}
