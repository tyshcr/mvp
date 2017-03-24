//
//  DetailViewController.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 3/24/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R
//

import UIKit

class DetailViewController: UIViewController {

    private var presenter: DetailPresenter!
    var data: TeamModelData?
    
    var _view: DetailView { return self.view as! DetailView }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = DetailPresenter(view: _view, model: data!)
        presenter.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "Title", message: "\(data!)", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: DetailPresenterDelegate {
    func something() {
        // something
    }
}
