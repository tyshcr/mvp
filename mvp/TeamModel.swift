//
//  TeamModel.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

struct TeamModelData {
    var city: String
    var nickname: String
    var wins: Int
    var losses: Int
}

protocol TeamModelDelegate: class {
    func startingServerCall()
    func teamModelDataReady()
}

protocol TeamModelInterface: class {
    var delegate: TeamModelDelegate? { get set }
    var teamModelData: [TeamModelData] { get }
    var teamViewData: [TeamViewData] { get }
    
    // TODO: make teamViewData() into var ?
    func runServerCall()
    func teamViewData(teamModeData: [TeamModelData]) -> [TeamViewData]
    func teamName(city: String, nickname: String) -> String
    func winPercentage(wins: Int, losses: Int) -> String
}

class TeamModel: TeamModelInterface {
    
    weak var delegate: TeamModelDelegate?
    var teamModelData = [TeamModelData]()
    var teamViewData = [TeamViewData]()
    let server = Server()
    
    func runServerCall() {
        
        self.delegate?.startingServerCall()
        
        server.getData { (segments: [[String : Any]]) in
            
            // TODO: send data to Model for formatting, return via model.delegate, pass to view
            
            for segment in segments {
                
                let teams = segment["rows"] as! [[String:Any]]
                
                for team in teams {
                    let city = team["city"] as! String
                    let nickname = team["nickname"] as! String
                    let wins = team["wins"] as! Int
                    let losses = team["losses"] as! Int
                    
                    let teamData = TeamModelData(city: city,
                                                 nickname: nickname,
                                                 wins: wins,
                                                 losses: losses)
                    self.teamModelData.append(teamData)
                }
                
            } // for
            
            self.teamViewData = self.teamViewData(teamModeData: self.teamModelData)
            
            DispatchQueue.main.async {
                self.delegate?.teamModelDataReady()
            }
            
        } // server.getData()
        
    } // runServerCall
    
    func teamViewData(teamModeData: [TeamModelData]) -> [TeamViewData] {
        var teamViewData: [TeamViewData] = []
        
        for team in teamModelData {
            let fullName = teamName(city: team.city, nickname: team.nickname)
            let percentage = winPercentage(wins: team.wins, losses: team.losses)
            teamViewData.append(TeamViewData(fullName: fullName, wins: team.wins, losses: team.losses, percentage: percentage))
        }
        
        return teamViewData
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
    
} // class
