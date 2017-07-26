//
//  APIUser.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import PromiseKit

protocol APIUser: APIJSON {
    func login(withName name: String,
               email: String,
               password: String) -> Promise<[String : AnyObject]>
}

extension APIUser {
    func login(withName name: String,
               email: String,
               password: String) -> Promise<[String : AnyObject]>{
        let POSTUserDataDictionary = ["name": name,
                              "email": email,
                              "password": password]
        return postRequest(data: POSTUserDataDictionary as [String : AnyObject])
    }
}
