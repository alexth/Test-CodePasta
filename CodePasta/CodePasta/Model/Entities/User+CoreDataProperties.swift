//
//  User+CoreDataProperties.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var userID: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var pastas: NSSet?

}

// MARK: Generated accessors for pastas
extension User {

    @objc(addPastasObject:)
    @NSManaged public func addToPastas(_ value: Pasta)

    @objc(removePastasObject:)
    @NSManaged public func removeFromPastas(_ value: Pasta)

    @objc(addPastas:)
    @NSManaged public func addToPastas(_ values: NSSet)

    @objc(removePastas:)
    @NSManaged public func removeFromPastas(_ values: NSSet)

}
