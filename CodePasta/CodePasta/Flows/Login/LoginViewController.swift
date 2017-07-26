//
//  LoginViewController.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit
import PromiseKit

class LoginViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    fileprivate let toMainSegue = "toMain"

    // MARK: - View lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }

    // MARK: - Navigation and Data transfer

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    // MARK: - Business logic

    fileprivate func handleLogin(name: String!,
                                 email: String!,
                                 password: String!) {
        // TODO: Disabled until API will be available

//        let userAPI: APIUser = NetworkManager.shared
//        userAPI.login(withName: name,
//                      email: email,
//                      password: password).then { responseDictionary -> Void in
//                        self.handleSuccessLogin(response: responseDictionary)
//        }.catch { error in
//            self.handle(error: error)
//        }
        // TODO: Only for test purposes, need to be removed ⬇︎
        let testResponse = ["name" : name,
                            "id" : "userID",
                            "creationDate" : Date()] as [String : AnyObject]
        self.handleSuccessLogin(response: testResponse)
    }

    fileprivate func handleSuccessLogin(response: [String : AnyObject]) {
        guard let name = response["name"] as? String,
            let userID = response["id"] as? String,
            let creationDate = response["creationDate"] as? Date // TODO: needs to be correctly handled
            else {
                let error = NSError(domain: "Server",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey : "Server Data error"])
                handle(error: error)
                return
        }
        let databaseManager = DatabaseManager.shared
        databaseManager.createUser(name: name,
                                   userID: userID,
                                   creationDate: creationDate).then { user -> Void in
                                    self.performSegue(withIdentifier: self.toMainSegue, sender: self)
        }.catch { error in
            let error = NSError(domain: "Device",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey : "Device Data error"])
            self.handle(error: error)
        }
    }

    fileprivate func handle(error: Error) {
        // TODO: Add adequate error handling
        print(error)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            // TODO: Add input validation with error handling
            if let name = nameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text {
                handleLogin(name: name,
                            email: email,
                            password: password)
            } else {
                let error = NSError(domain: "Validation",
                                    code: 0,
                                    userInfo: [NSLocalizedDescriptionKey : "Validation error"])
                handle(error: error)
            }
        }
        return false
    }
}
