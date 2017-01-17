//
//  Presenter.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

protocol PresenterDelegate {
    func setupData(incomingData: [Team])
}

class Presenter {
    var delegate: PresenterDelegate?
    var data = [Team]()
    
    init() { }
    
    func getData() {
        data.removeAll()
        
        // TODO: Fetch JSON from file 
        let team1 = Team(city: "Cleveland", nickname: "Cavaliers", wins: 29, losses: 11)
        let team2 = Team(city: "Toronto", nickname: "Raptors", wins: 27, losses: 13)
        let team3 = Team(city: "Boston", nickname: "Celtics", wins: 26, losses: 15)
        
        data.append(team1)
        data.append(team2)
        data.append(team3)
        
        delegate?.setupData(incomingData: data)
    }
    
}
