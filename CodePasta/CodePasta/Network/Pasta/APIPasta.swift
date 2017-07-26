//
//  APIPasta.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import PromiseKit

protocol APIPasta: APIJSON {
    func sendPasta(name: String,
                   text: String,
                   creationDate: Date) -> Promise<[String : AnyObject]>
}

extension APIPasta {
    func sendPasta(name: String,
                   text: String,
                   creationDate: Date) -> Promise<[String : AnyObject]> {
        let POSTPastaDictionary = ["name": name,
                                   "text": text,
                                   "creationDate": creationDate] as [String : AnyObject]
        return postRequest(data: POSTPastaDictionary)
    }
}
