//
//  DatabaseManager+Pasta.swift
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
    func createUpdatePasta(name: String,
                           code: String,
                           pastaID: String,
                           creationDate: Date) -> Promise<Pasta> {
        return Promise { (fulfill, reject) -> Void in
            let fetchResponse = fetchPasta()
            if let error = fetchResponse.error {
                reject(error)
            } else {
                let pasta: Pasta!
                if let fetchedpasta = fetchResponse.pasta {
                    pasta = fetchedpasta
                } else {
                    pasta = NSEntityDescription.insertNewObject(forEntityName: "Pasta", into: managedObjectContext) as! Pasta
                    pasta.pastaID = pastaID
                    pasta.creationDate = creationDate as NSDate
                }
                pasta.name = name
                pasta.code = code
                do {
                    try managedObjectContext.save()
                    fulfill(pasta)
                } catch {
                    reject(error)
                }
            }
        }
    }

    func fetchPasta() -> (pasta: Pasta?, error: NSError?) {
        var pastasArray = [Pasta]()
        let fetchRequest = pastaFetchRequest()
        do {
            pastasArray = try managedObjectContext.fetch(fetchRequest)
            if pastasArray.count == 1 {
                return (pastasArray.first!, nil)
            } else if pastasArray.count == 0 {
                return (nil, nil)
            } else {
                return (nil, pastaDuplicationError())
            }
        } catch let error as NSError {
            return (nil, error)
        }
    }

    func pastas() -> [Pasta] {
        var pastasArray = [Pasta]()
        let fetchRequest = pastaFetchRequest()
        do {
            pastasArray = try managedObjectContext.fetch(fetchRequest)
        } catch let error as NSError {
            // TODO: Add adequate error handling
            print("ERROR! Fetch failed: \(error.localizedDescription)")
        }
        return pastasArray
    }

    fileprivate func pastaFetchRequest() -> NSFetchRequest<Pasta> {
        let fetchRequest: NSFetchRequest<Pasta> = Pasta.fetchRequest()
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "Pasta", in: managedObjectContext)
        return fetchRequest
    }
}

fileprivate extension DatabaseManager {
    fileprivate func pastaDuplicationError() -> NSError {
        return NSError(domain: "pastaDuplicationError",
                       code: 0,
                       userInfo: [NSLocalizedDescriptionKey: "duplicate pasta found"])
    }
}