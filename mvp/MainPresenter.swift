//
//  MainPresenter.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

protocol MainPresenterDelegate: class {
    func startLoading()
    func finishLoading()
    func setTeams(incomingData: [TeamViewData])
    func pushTeamView(for indexPath: IndexPath)
}

protocol MainPresenterInterface: class {
    var delegate: MainPresenterDelegate? { get set }
    
    func requestData()
    func teamName(city: String, nickname: String) -> String
    func winPercentage(wins: Int, losses: Int) -> String
}

class MainPresenter: MainPresenterInterface {
    weak var delegate: MainPresenterDelegate?
    
    var teamViewData = [TeamViewData]()
    let model: TeamModel
    let view: MainView
    
    private var teamModelDelegate: TeamModelDelegate!
    private var viewDelegate: MainViewDelegate!
    
    init(view: MainView, model: TeamModel) {
        self.view = view
        self.model = model
        self.view.delegate = self
        self.model.delegate = self
    }
    
    func requestData() {
        self.model.runServerCall()
    }
    
    // MARK: - Data Manipulation
    func teamName(city: String, nickname: String) -> String {
        return model.teamName(city: city, nickname: nickname)
    }
    
    func winPercentage(wins: Int, losses: Int) -> String {
        return model.winPercentage(wins: wins, losses: losses)
    }
    
}


// MARK - ViewDelegate
extension MainPresenter: MainViewDelegate {
    func tappedCell(at indexPath: IndexPath) {
        delegate?.pushTeamView(for: indexPath)
    }
}


// MARK: - TeamModelDelegate
extension MainPresenter: TeamModelDelegate {
    
    func startingServerCall() {
        self.delegate?.startLoading()
    }
    
    func teamModelDataReady() {
        self.delegate?.setTeams(incomingData: model.teamViewData)
        self.delegate?.finishLoading()
    }
    
}
