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
    var _view: View { return self.view as! View }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Presenter.init(view: _view)
        presenter.delegate = self
        presenter.requestData()
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
        self.performSegue(withIdentifier: "MainVCToDetailVC", sender: self)
    }
}
