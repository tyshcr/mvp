//
//  ViewController.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R 
//

import UIKit

class ViewController: UIViewController {
    
    private var presenter: Presenter!
    var _view: View!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Presenter()
        presenter.delegate = self
        
        _view = self.view as! View
        _view.configure(presenter: presenter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - PresenterDelegate
extension ViewController: PresenterDelegate {
    func startLoading() {
        _view.startSpinner()
    }
    
    func finishLoading() {
        _view.stopSpinner()
    }
    
    func setTeams(incomingData: [TeamViewData]) {
        _view.updateTableData(data: incomingData)
    }
    
    func pushNewView() {
        print("VC PUSH NEW VIEW")
    }
}
