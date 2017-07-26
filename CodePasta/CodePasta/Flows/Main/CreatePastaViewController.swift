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
        // TODO: Add adequate validation
        if let name = nameTextField.text,
            let code = pastaTextView.text {
            let isNameLongEnough = name.characters.count > 1
            let isCodeLongEnough = code.characters.count > 1
            if  isNameLongEnough || isCodeLongEnough {
                let databaseManager = DatabaseManager.shared
                databaseManager.createUpdatePasta(name: name,
                                                  code: code,
                                                  pastaID: "\(Int.randomInt(from: 0, to: 100000))", // TODO: test
                                                  creationDate: Date()) // TODO: test
            } else {
                // TODO: Show error
            }
        }
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

// TODO: Only for test purposes. Remove it
fileprivate extension Int {
    static func randomInt(from lower: Int, to higher: Int) -> Int {
        var safeLower = lower
        var safeHigher = higher
        if safeLower > safeHigher {
            swap(&safeLower, &safeHigher)
        }
        return Int(arc4random_uniform(UInt32(safeHigher - safeLower + 1))) + safeLower
    }
}
