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
    let percentage: String
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
        
        let server = Server()
        server.getData { (teams: [[String : Any]]) in

            for team in teams {
                
                let city = team["first_name"] as! String
                let nickname = team["last_name"] as! String
                let fullName = self.teamName(city: city, nickname: nickname)
                
                let wins = team["won"] as! Int
                let losses = team["lost"] as! Int
                let percentage = self.winPercentage(wins: wins, losses: losses)
                
                let teamData = TeamViewData(fullName: fullName,
                                            wins: wins,
                                            losses: losses,
                                            percentage: percentage)
                self.data.append(teamData)

            }
                
            DispatchQueue.main.async {
                self.delegate?.setTeams(incomingData: self.data)
                self.delegate?.finishLoading()
            }
            
        }
        
    }
    
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
}
