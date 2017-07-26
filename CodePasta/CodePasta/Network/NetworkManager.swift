//
//  NetworkManager.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkManager {
    static let shared = NetworkManager()
    fileprivate init() {}
}

extension NetworkManager: APIUser, APIPasta {}

protocol APIJSON {
    func postRequest(data: [String : AnyObject]) -> Promise<[String : AnyObject]>
}

extension APIJSON {
    func postRequest(data: [String : AnyObject]) -> Promise<[String : AnyObject]> {
        return Promise { (fulfill, reject) -> Void in
            do {
                var request = self.serverURLRequest()
                request.httpBody = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        reject(error!)
                        return
                    }
                    do {
                        guard let responseObject = try? JSONSerialization.jsonObject(with: data) else {
                            reject(self.userError(code: 0, errorMessage: "ERROR! Can't reach server"))
                            return
                        }
                        let responseDictionary = responseObject as! [String : AnyObject]
                        self.handle(responseDictionary: responseDictionary).then { response -> () in
                            fulfill(response)
                        }.catch { error in
                            reject(error)
                        }
                    }
                }.resume()
            } catch let error {
                reject(error)
            }
        }
    }

    func userError(code: Int, errorMessage: String) -> NSError {
        return NSError(domain: "userDataError",
                       code: code,
                       userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }

    fileprivate func handle(responseDictionary: [String : AnyObject]) -> Promise<[String : AnyObject]> {
        return Promise { (fulfill, reject) -> Void in
            if responseDictionary["errorMsg"] != nil {
                let code = responseDictionary["returnCode"] as! Int
                let errorMessage = responseDictionary["errorMsg"] as! String
                let error = self.serverError(code: code, errorMessage: errorMessage)
                reject(error)
            } else {
                fulfill(responseDictionary)
            }
        }
    }

    fileprivate func serverURLRequest() -> URLRequest {
        var request = URLRequest(url: APIConfiguration().baseServerURL())
        setupAttributes(toRequest: &request)
        return request
    }

    fileprivate func setupAttributes(toRequest request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
    }

    fileprivate func serverError(code: Int, errorMessage: String) -> NSError {
        return NSError(domain: "serverError",
                       code: code,
                       userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }
}
