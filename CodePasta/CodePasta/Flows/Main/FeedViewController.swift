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
    fileprivate let fetchLimit: Int = 20

    // MARK: - View lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateDataSource()
    }

    // MARK: - Util

    private func updateDataSource() {
        let databaseManager = DatabaseManager.shared
        pastasArray = databaseManager.pastas(fetchLimit: fetchLimit)
        feedTableView.reloadData()
    }
}

extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedTableViewNumberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pastasArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dictionaryCellIdentifier, for: indexPath) 
        let pasta = pastasArray[indexPath.row]
        cell.textLabel?.text = pasta.name
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
