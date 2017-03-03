//
//  ViewController.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R 
//

import UIKit

struct TeamViewData {
    let fullName: String
    let wins: Int
    let losses: Int
    let percentage: String
}

class ViewController: UIViewController {

    private var presenter: Presenter!
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var processedData = [TeamViewData]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        
        presenter = Presenter()
        presenter.delegate = self
        presenter.requestData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UITableViewDataSource
// TODO: separate into view
// TODO: func to create segmented control for segments
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return processedData.count
    }
    
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
extension ViewController: PresenterDelegate {
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

