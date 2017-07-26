//
//  LoginViewController.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - View lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }

    // MARK: - Business logic

    fileprivate func handleLogin(name: String!,
                                 email: String!,
                                 password: String!) {
        let userAPI: APIUser = NetworkManager.shared
        userAPI.login(withName: name,
                      email: email,
                      password: password).then { responseDictionary -> Void in
                        self.handleSuccessLogin(response: responseDictionary)
        }.catch { error in
            self.handle(error: error)
        }
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
                                   creationDate: creationDate)
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
