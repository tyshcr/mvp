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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailViewController: DetailPresenterDelegate {
    func something() {
        // something
    }
}
