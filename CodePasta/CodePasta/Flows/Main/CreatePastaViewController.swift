//
//  CreatePastaViewController.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit

class CreatePastaViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pastaTextView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(recognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }

    // MARK: - Actions

    @IBAction func savePasta(button: UIButton) {

    }

    @objc fileprivate func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension CreatePastaViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTextField {
            pastaTextView.becomeFirstResponder()
        }
        return false
    }
}
