//
//  DatabaseManager+User.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import CoreData

extension DatabaseManager {
    func createUpdateUser(name: String,
                          userID: String,
                          creationDate: Date) -> (user: User?, error: NSError?) {
        let fetchResponse = fetchUser()
        if let error = fetchResponse.error {
            return (nil, error)
        } else {
            let user: User!
            if let fetchedUser = fetchResponse.user {
                user = fetchedUser
            } else {
                user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as! User
                user.userID = userID
            }
            user.name = name
            user.creationDate = creationDate as NSDate
            do {
                try managedObjectContext.save()
                return (user, nil)
            } catch {
                return (nil, error as NSError)
            }
        }
    }

    func users() -> [User] {
        var usersArray = [User]()
        let fetchRequest = userFetchRequest()
        do {
            usersArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            // TODO: Handle issue properly
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return usersArray
    }

    func fetchUser() -> (user: User?, error: NSError?) {
        var usersArray = [User]()
        let fetchRequest = userFetchRequest()
        do {
            usersArray = try managedObjectContext.fetch(fetchRequest)
            if usersArray.count == 1 {
                if let user = usersArray.first {
                    return (user, nil)
                }
            } else if usersArray.count == 0 {
                return (nil, nil)
            } else {
                return (nil, userDuplicationError())
            }
        } catch let error as NSError {
            return (nil, error)
        }
        return (nil, nil)
    }

    fileprivate func userFetchRequest() -> NSFetchRequest<User> {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
        return fetchRequest
    }
}

fileprivate extension DatabaseManager {
    fileprivate func userDuplicationError() -> NSError {
        return NSError(domain: "userDuplicationError",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: "duplicate user found"])
    }

    fileprivate func noUsersError() -> NSError {
        return NSError(domain: "noUsersError",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: "no users found"])
    }
}
