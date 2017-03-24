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

protocol TeamModelDelegate {
    func startingServerCall()
    func teamModelDataReady()
}

class TeamModel {
    
    var delegate: TeamModelDelegate?
    var teamModelData = [TeamModelData]()
    let server = Server()
    
    init() { }
    
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
            
            DispatchQueue.main.async {
                self.delegate?.teamModelDataReady()
            }
            
        } // server.getData()
        
    } // runServerCall
    
} // class
