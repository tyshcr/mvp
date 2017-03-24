//
//  DetailView.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 3/24/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R. All rights reserved.
//

import UIKit

protocol DetailViewDelegate {
    func tapped()
}

class DetailView: UIView, UITableViewDataSource, UITableViewDelegate {

    var delegate: DetailViewDelegate?
    var tableData: TeamModelData?
    
    @IBOutlet weak var tableView: UITableView!
    
    func updateTableData(data: TeamModelData) {
        tableData = data
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "TeamCell")
        var value: String {
            switch indexPath.row {
            case 1:
                return "\(tableData?.wins)"
            case 2:
                return "\(tableData?.losses)"
            default:
                return "\(tableData?.city) \(tableData?.nickname)"
            }
        }
        
        cell.textLabel?.text = value
//        cell.detailTextLabel?.text = "wins:" + String(currentCellData.wins) + "  losses:" + String(currentCellData.losses) + "  pct:" + currentCellData.percentage
        
        cell.setNeedsDisplay()
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        delegate?.tappedCell(at: indexPath)
//    }

}
