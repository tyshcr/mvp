//
//  View.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R [AG-Contractor/1000] on 3/17/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R [AG-Contractor/1000]. All rights reserved.
//

import UIKit

class View: UIView, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var processedData = [TeamViewData]()
    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return processedData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "TeamCell")
        let currentCellData = processedData[indexPath.row]
        
        cell.textLabel?.text = currentCellData.fullName
        cell.detailTextLabel?.text = "wins:" + String(currentCellData.wins) + "  losses:" + String(currentCellData.losses) + "  pct:" + currentCellData.percentage
        
        cell.setNeedsDisplay()
        return cell
    }
}

// MARK: - PresenterDelegate
// TODO: separate into view
extension View: PresenterDelegate {
    func startLoading() {
        spinner.startAnimating()
    }
    
    func finishLoading() {
        spinner.stopAnimating()
    }
    
    func setTeams(incomingData: [TeamViewData]) {
        processedData = incomingData
        self.tableView?.reloadData()
    }
    
}
