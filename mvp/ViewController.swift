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
    let model: TeamModel = TeamModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = Presenter.init(view: _view, model: model)
        presenter.delegate = self
        presenter.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MainVCToDetailVC") {
            let indexPath = sender as? IndexPath
            segue.destination.navigationItem.title = model.teamModelData[(indexPath?.row)!].city
        }
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
    
    func pushTeamView(for indexPath: IndexPath) {
        self.performSegue(withIdentifier: "MainVCToDetailVC", sender: indexPath)
    }
}
