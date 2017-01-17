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
    @IBOutlet weak var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        presenter = Presenter()
        presenter.delegate = self
        presenter.getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension ViewController: PresenterDelegate {
    func setupData(incomingData: [Team]) {
        label.text = ""
        
        for team in incomingData {
            label.text?.append(team.city + " " + team.nickname + " : " + String(team.wins) + " - " + String(team.losses))
            label.text?.append("\n")
        }
    }

}

