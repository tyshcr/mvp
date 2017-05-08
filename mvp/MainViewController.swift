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
    var _view: MainViewInterface { return self.view as! MainViewInterface }
    let model: TeamModelInterface = TeamModel() as TeamModelInterface
    
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
            let vc = segue.destination as! DetailViewController
            vc.data = model.teamModelData[(indexPath?.row)!]
            vc.navigationItem.title = vc.data?.city
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
