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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }

    // MARK: - Business logic

    fileprivate func handleLogin(withName: String!,
                                 email: String!,
                                 password: String!) {

    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            // TODO: Add input validation
            if let name = nameTextField.text,
                let email = emailTextField.text,
                let password = passwordTextField.text {
            handleLogin(withName: name,
                        email: email,
                        password: password)
            } else {
                // TODO: Show proper error to User
            }
        }
        return false
    }
}
