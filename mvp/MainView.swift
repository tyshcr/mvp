//
//  View.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 3/17/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import UIKit

// TODO: Add ViewDelegate

struct TeamViewData {
    let fullName: String
    let wins: Int
    let losses: Int
    let percentage: String
}

protocol MainViewDelegate {
    func tappedCell(at indexPath: IndexPath)
}

class MainView: UIView, UITableViewDataSource, UITableViewDelegate {
    var delegate: MainViewDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var tableData = [TeamViewData]()
    
    // MARK: - View Functions
    func startSpinner() {
        spinner.startAnimating()
    }
    
    func stopSpinner() {
        spinner.stopAnimating()
    }
    
    func updateTableData(data: [TeamViewData]) {
        tableData = data
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "TeamCell")
        let currentCellData = tableData[indexPath.row]
        
        cell.textLabel?.text = currentCellData.fullName
        cell.detailTextLabel?.text = "wins:" + String(currentCellData.wins) + "  losses:" + String(currentCellData.losses) + "  pct:" + currentCellData.percentage
        
        cell.setNeedsDisplay()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tappedCell(at: indexPath)
    }
}
