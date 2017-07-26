//
//  CreatePastaViewController.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit

class CreatePastaViewController: UIViewController, ToastViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pastaTextView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!

    fileprivate let animationDuration: TimeInterval = 0.3
    fileprivate let textViewBottomConstraintHeight: CGFloat = 20.0

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGestureToBackground()
        addKeyboardObservers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nameTextField.becomeFirstResponder()
    }

    // MARK: - Actions

    @IBAction func savePasta(button: UIButton) {
        if let name = nameTextField.text,
        let code = pastaTextView.text {
            savePasta(name: name, code: code)
        } else {
            showError(text: "Nothing to save")
        }
    }

    @IBAction func sharePasta(button: UIButton) {
        let networkManager = NetworkManager.shared
        let name = nameTextField.text ?? ""
        let code = pastaTextView.text ?? ""
        let creationDate = Date() // TODO: Only for test purposes
        networkManager.sendPasta(name: name,
                                 code: code,
                                 creationDate: creationDate).then { response -> Void in
                                    self.savePasta(name: name, code: code)
        }.catch { error in
            self.showError(text: error.localizedDescription)
        }
    }

    private func savePasta(name: String, code: String) {
        // TODO: Add adequate validation
        let isNameLongEnough = name.characters.count > 1
        let isCodeLongEnough = code.characters.count > 1
        if  isNameLongEnough || isCodeLongEnough {
            let databaseManager = DatabaseManager.shared
            databaseManager.createUpdatePasta(name: name,
                                              code: code,
                                              pastaID: "\(Int.randomInt(from: 0, to: 100000))", // TODO: test
                creationDate: Date()) // TODO: test
            self.view.endEditing(true)
            self.showInfo(text: "Saved!")
        } else {
            showError(text: "Nothing to save")
        }
    }

    // MARK: - Utils

    @objc fileprivate func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    private func addTapGestureToBackground() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(recognizer:)))
        view.addGestureRecognizer(gestureRecognizer)
    }

    private func addKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillHide(notification:)),
                                       name:NSNotification.Name.UIKeyboardWillHide,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(keyboardWillShow(notification:)),
                                       name:NSNotification.Name.UIKeyboardWillShow,
                                       object: nil)
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

extension CreatePastaViewController {
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: animationDuration) {
            self.textViewBottomConstraint.constant = self.textViewBottomConstraintHeight
        }
    }

    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        UIView.animate(withDuration: animationDuration) {
            self.textViewBottomConstraint.constant = keyboardSize.height + 10.0
        }
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
