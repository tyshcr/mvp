//
//  mvpTests.swift
//  mvpTests
//
//  Created by TYSH, CHRISTOPHER R on 1/11/17.
//  Copyright © 2017 TYSH, CHRISTOPHER R All rights reserved.
//

import XCTest
@testable import mvp

class mvpTests: XCTestCase {
    
    var view: MainView!
    var model: TeamModel!
    var presenter: MainPresenter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        view = MainView()
        model = TeamModel()
        presenter = MainPresenter(view: view, model: model)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTeamName() {
        let city = "Cleveland"
        let nickname = "Cavaliers"
        let fullName = presenter.teamName(city: city, nickname: nickname)
        XCTAssertTrue(fullName=="Cleveland Cavaliers")
    }
    
    func testWinPercentage() {
        var wins = 10
        var losses = 10
        var percentage = presenter.winPercentage(wins: wins, losses: losses)
        XCTAssertTrue(percentage==".500")
        
        wins = 20
        losses = 0
        percentage = presenter.winPercentage(wins: wins, losses: losses)
        XCTAssertTrue(percentage=="1.000")
        
        wins = 0
        losses = 20
        percentage = presenter.winPercentage(wins: wins, losses: losses)
        XCTAssertTrue(percentage==".000")
        
        wins = 15
        losses = 5
        percentage = presenter.winPercentage(wins: wins, losses: losses)
        XCTAssertTrue(percentage==".750")
        
        wins = 5
        losses = 15
        percentage = presenter.winPercentage(wins: wins, losses: losses)
        XCTAssertTrue(percentage==".250")
    }
    
}
