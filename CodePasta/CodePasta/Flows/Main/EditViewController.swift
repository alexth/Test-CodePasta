//
//  EditViewController.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pastaLabel: UILabel!

    var pasta: Pasta!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pasta.name
        pastaLabel.text = pasta.code
    }
}
