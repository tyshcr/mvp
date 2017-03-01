//
//  Server.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 2/28/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import Foundation
import UIKit

class Server {
    
    func getData(completion: @escaping (_ teams: [[String: Any]] ) -> ()) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate 
        let dataUrl = appDelegate.dataUrl // Get dataUrl from AppDelegate.swift
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: dataUrl)!
        
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
