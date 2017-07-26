//
//  FeedViewController.swift
//  CodePasta
//
//  Created by Alex Golub on 7/26/17.
//  Copyright © 2017 Alex Golub. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var feedTableView: UITableView!

    fileprivate var pastasArray: [Pasta]!

    fileprivate let dictionaryCellIdentifier = "feedCell"
    fileprivate let feedTableViewNumberOfSections: Int = 1
    fileprivate let feedTableViewCellHeight: CGFloat = 50.0
    fileprivate let feedTableViewHeaderFooterHeight: CGFloat = 0.01

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedTableViewNumberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return pastasArray.count
return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dictionaryCellIdentifier, for: indexPath) 
//        let pasta = pastasArray[indexPath.row]
        // TODO : extend Pasta with name property
//        cell.textLabel?.text = pasta.name
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return feedTableViewHeaderFooterHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return feedTableViewHeaderFooterHeight
    }
}
