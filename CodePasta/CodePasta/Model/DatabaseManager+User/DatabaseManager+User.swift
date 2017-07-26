//
//  DatabaseManager+User.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import CoreData
import PromiseKit

extension DatabaseManager {
    @discardableResult
    func createUser(name: String,
                    userID: String,
                    creationDate: Date) -> Promise<User> {
        return Promise { (fulfill, reject) -> Void in
            let fetchResponse = fetchUser()
            if let error = fetchResponse.error {
                reject(error)
            } else {
                let user: User!
                if let fetchedUser = fetchResponse.user {
                    user = fetchedUser
                } else {
                    user = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedObjectContext) as! User
                    user.userID = userID
                    user.creationDate = creationDate as NSDate
                }
                user.name = name
                do {
                    try managedObjectContext.save()
//                    print("User - \(user)")
                    fulfill(user)
                } catch {
                    reject(error)
                }
            }
        }
    }

    func users() -> [User] {
        var usersArray = [User]()
        let fetchRequest = userFetchRequest()
        do {
            usersArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            // TODO: Add adequate error handling
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
                return (usersArray.first!, nil)
            } else if usersArray.count == 0 {
                return (nil, nil)
            } else {
                return (nil, userDuplicationError())
            }
        } catch let error as NSError {
            return (nil, error)
        }
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
