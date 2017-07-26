//
//  Comment+CoreDataProperties.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var commentID: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var text: String?
    @NSManaged public var pasta: Pasta?

}
