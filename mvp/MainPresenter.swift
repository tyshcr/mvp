//
//  MainPresenter.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

protocol MainPresenterDelegate: class {
    func pushTeamView(for indexPath: IndexPath)
}

protocol MainPresenterInterface: class {
    var delegate: MainPresenterDelegate? { get set }
    func requestData()
}

class MainPresenter: MainPresenterInterface {
    weak var delegate: MainPresenterDelegate?
    
    var teamViewData = [TeamViewData]()
    let model: TeamModelInterface
    let view: MainViewInterface
    
    init(view: MainViewInterface, model: TeamModelInterface) {
        self.view = view
        self.model = model
        self.view.delegate = self
        self.model.delegate = self
    }
    
    func requestData() {
        self.model.runServerCall()
    }
    
}


// MARK - MainViewDelegate
extension MainPresenter: MainViewDelegate {
    func tappedCell(at indexPath: IndexPath) {
        delegate?.pushTeamView(for: indexPath)
    }
}


// MARK: - TeamModelDelegate
extension MainPresenter: TeamModelDelegate {
    
    func startingServerCall() {
        self.view.startSpinner()
    }
    
    func teamModelDataReady() {
        self.view.updateTableData(data: model.teamViewData)
        self.view.stopSpinner()
    }
    
}
