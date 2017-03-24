//
//  MainViewController.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R 
//

import UIKit

class MainViewController: UIViewController {
    
    private var presenter: MainPresenter!
    var _view: MainView { return self.view as! MainView }
    let model: TeamModel = TeamModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainPresenter.init(view: _view, model: model)
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
extension MainViewController: MainPresenterDelegate {
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
