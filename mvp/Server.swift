//
//  Server.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 2/28/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation

class Server {
    
    func getData(completion: @escaping (_ teams: [[String: Any]] ) -> ()) {
       
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://www.feltpad.net/nba.json")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any] {
                        let teams = json["standing"] as? [[String:Any]]
                        completion(teams!)
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                }
                
            }
            
        })
        task.resume()
    }
    
}
