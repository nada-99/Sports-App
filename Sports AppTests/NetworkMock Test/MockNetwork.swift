//
//  MockNetwork.swift
//  Sports AppTests
//
//  Created by Nada on 30/05/2023.
//

import XCTest

final class MockNetwork: XCTestCase {
    
    var fakeNetworkObj = FakeNetwork(shouldReturnError: false)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetAllLeagues(){
        let exp = expectation(description: "Network")
        
        FakeNetwork.getAllLeagues(sportName: "football", completionHandler: { result in
            XCTAssertNil(result)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5)
    }
    
    func testGetUpComingEvents(){
        let exp = expectation(description: "Network")
        
        FakeNetwork.getUpComingEvents(sportName: "football", leagueId: 3, completionHandler: { result in
            XCTAssertNotNil(result)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5)
    }
    
    func testGetLatestEvents(){
        let exp = expectation(description: "Network")
        
        FakeNetwork.getLatestEvents(sportName: "football", leagueId: 3, completionHandler: { result in
            XCTAssertNotNil(result)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5)
    }
    
    func testGetTeams(){
        let exp = expectation(description: "Network")
        
        FakeNetwork.getTeams(sportName: "football", leagueId: 3, completionHandler: { result in
            XCTAssertNotNil(result)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5)
    }
    
    func testGetTeamsDetails(){
        let exp = expectation(description: "Network")
        
        FakeNetwork.getTeamDetails(teamId: 3, completionHandler: { result in
            XCTAssertNotNil(result)
            exp.fulfill()
        })

        waitForExpectations(timeout: 5)
    }

}
