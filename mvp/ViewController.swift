//
//  ViewController.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R [AG-Contractor/1000] on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R [AG-Contractor/1000]. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var presenter: Presenter!
    @IBOutlet weak var tableView: UITableView?
    
    var processedData = [Team]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.dataSource = self
        
        presenter = Presenter()
        presenter.delegate = self
        presenter.getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "TeamCell")
        let currentCellData = processedData[indexPath.row]
        
        cell.textLabel?.text = currentCellData.city
        cell.detailTextLabel?.text = String(currentCellData.wins) + " - " + String(currentCellData.losses)
        
        return cell
    }
}

extension ViewController: PresenterDelegate {
    func setupData(incomingData: [Team]) {

        for team in incomingData {
           processedData.append(team)
        }
    }

}

