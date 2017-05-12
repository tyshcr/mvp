//
//  DetailPresenter.swift
//  mvp
//
//  Created by TYSH, CHRISTOPHER R on 3/24/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R. All rights reserved.
//

import Foundation

protocol DetailPresenterDelegate {
    func something()
}

class DetailPresenter {
    var delegate: DetailPresenterDelegate?
    private var view: DetailView?
    private var model: TeamModelData
    
    init(view: DetailView, model: TeamModelData) {
        self.model = model
        self.view = view
        self.view?.delegate = self
        self.view?.updateTableData(data: model)
    }
}

extension DetailPresenter: DetailViewDelegate {
    func tapped() {
        // tapped
    }
}
