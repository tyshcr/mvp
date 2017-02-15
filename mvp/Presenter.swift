//
//  Presenter.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

struct TeamViewData {
    let fullName: String
    let wins: Int
    let losses: Int
}

protocol PresenterDelegate {
    func startLoading()
    func finishLoading()
    func setTeams(incomingData: [TeamViewData])
}

class Presenter {
    var delegate: PresenterDelegate?
    var data = [TeamViewData]()
    
    init() { }
    
    func getData() {
        delegate?.startLoading()
        
        data.removeAll()
        
        // TODO: Fetch JSON from file / service
        let team1 = Team(city: "Cleveland", nickname: "Cavaliers", wins: 29, losses: 11)
        let team2 = Team(city: "Toronto", nickname: "Raptors", wins: 27, losses: 13)
        let team3 = Team(city: "Boston", nickname: "Celtics", wins: 26, losses: 15)
        
        // TODO: Loop through the data and format it for the view
        let team1data = TeamViewData(fullName: teamName(city: team1.city, nickname: team1.nickname), wins: team1.wins, losses: team1.losses)
        let team2data = TeamViewData(fullName: teamName(city: team2.city, nickname: team2.nickname), wins: team2.wins, losses: team2.losses)
        let team3data = TeamViewData(fullName: teamName(city: team3.city, nickname: team3.nickname), wins: team3.wins, losses: team3.losses)
        
        data.append(team1data)
        data.append(team2data)
        data.append(team3data)
        
        delegate?.finishLoading()
        delegate?.setTeams(incomingData: data)
    }
    
    func teamName(city: String, nickname: String) -> String {
        return "\(city) \(nickname)"
    }
}
