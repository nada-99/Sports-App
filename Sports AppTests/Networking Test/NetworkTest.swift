//
//  NetworkTest.swift
//  Sports AppTests
//
//  Created by Nada on 30/05/2023.
//

import XCTest
@testable import Sports_App

final class NetworkTest: XCTestCase {
    
    var network: NetworkServicesProtocol!

    override func setUpWithError() throws {
        network = NetworkManager()
    }

    override func tearDownWithError() throws {
        network = nil
    }

    func testGetAllLeagues(){
        let expectation = XCTestExpectation(description: "Get all leagues")
        
        NetworkManager.getAllLeagues(sportName: "football") { (result) in
            XCTAssertNotNil(result, "Failed to get leagues")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGetUpComingEvents() {
        let expectation = XCTestExpectation(description: "Get upcoming events")
            
        NetworkManager.getUpComingEvents(sportName: "football", leagueId: 3) { (result) in
            XCTAssertNotNil(result, "Failed to get upcoming events")
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 10.0)
    }
        
    func testGetLatestEvents() {
        let expectation = XCTestExpectation(description: "Get latest events")
            
        NetworkManager.getLatestEvents(sportName: "football", leagueId: 3) { (result) in
            XCTAssertNotNil(result, "Failed to get latest events")
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 10.0)
    }
        
    func testGetTeams() {
        let expectation = XCTestExpectation(description: "Get teams")
            
        NetworkManager.getTeams(sportName: "football", leagueId: 3) { (result) in
            XCTAssertNotNil(result, "Failed to get teams")
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 10.0)
    }
        
    func testGetTeamDetails() {
        let expectation = XCTestExpectation(description: "Get team details")
            
        NetworkManager.getTeamDetails(teamId: 1) { (result) in
            XCTAssertNotNil(result, "Failed to get team details")
            expectation.fulfill()
        }
            
        wait(for: [expectation], timeout: 10.0)
    }
    
    

}
