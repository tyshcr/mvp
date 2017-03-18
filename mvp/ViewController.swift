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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.view as! View
        view.configure()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


