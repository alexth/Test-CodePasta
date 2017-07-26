//
//  Pasta+CoreDataProperties.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import CoreData


extension Pasta {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pasta> {
        return NSFetchRequest<Pasta>(entityName: "Pasta")
    }

    @NSManaged public var pastaID: String?
    @NSManaged public var name: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var updateDate: NSDate?
    @NSManaged public var code: String?
    @NSManaged public var user: User?
    @NSManaged public var comments: NSSet?

}

// MARK: Generated accessors for comments
extension Pasta {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: Comment)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: Comment)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
