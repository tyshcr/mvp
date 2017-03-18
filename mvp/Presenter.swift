//
//  Presenter.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

protocol PresenterDelegate {
    func startLoading()
    func finishLoading()
    func setTeams(incomingData: [TeamViewData])
    func pushNewView()
}

class Presenter {
    var delegate: PresenterDelegate?
    
    var teamViewData = [TeamViewData]()
    let model: TeamModel
    
    private var teamModelDelegate: TeamModelDelegate!
    
    init() {
        self.model = TeamModel()
        self.model.delegate = self
    }
    
    func requestData() {
        self.model.runServerCall()
    }
    
    // MARK: - Data Manipulation
    func teamName(city: String, nickname: String) -> String {
        return "\(city) \(nickname)"
    }
    
    func winPercentage(wins: Int, losses: Int) -> String {
        let games = wins + losses
        let percentage = Float(wins) / Float(games)
        var formattedPercentage =  String(format: "%.3f", percentage)
        
        if (percentage<1.0) {
            let index = formattedPercentage.index(formattedPercentage.startIndex, offsetBy: 1)
            formattedPercentage = formattedPercentage.substring(from: index)
        }
        
        return formattedPercentage
    }
    
    // MARK: - View Actions
    func cellTapped() {
        delegate?.pushNewView()
    }
}

// MARK: - TeamModelDelegate
extension Presenter: TeamModelDelegate {
    
    func startingServerCall() {
        self.delegate?.startLoading()
    }
    
    func teamModelDataReady() {
        
        teamViewData.removeAll()
        
        for team in model.teamModelData as [TeamModelData] {
            let fullName = teamName(city: team.city, nickname: team.nickname)
            let percentage = winPercentage(wins: team.wins, losses: team.losses)
            teamViewData.append(TeamViewData(fullName: fullName, wins: team.wins, losses: team.losses, percentage: percentage))
        }
        
        self.delegate?.setTeams(incomingData: teamViewData)
        self.delegate?.finishLoading()
        
    }
    
}
