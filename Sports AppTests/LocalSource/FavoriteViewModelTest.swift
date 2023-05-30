//
//  FavoriteViewModel.swift
//  Sports AppTests
//
//  Created by Nada on 30/05/2023.
//

import XCTest
@testable import Sports_App

final class FavoriteViewModelTest: XCTestCase {
    
    var favViewModel : FavoriteViewModel?
    let fakeLocalSource = FackeLocalSource()
    
    override func setUpWithError() throws {
        favViewModel = FavoriteViewModel(coreDataProtocol: FackeLocalSource())
    }

    override func tearDownWithError() throws {
        favViewModel = nil
    }
    
    func testInsertToFav(){
        let countBefore = favViewModel?.getAllLeagues().count
        fakeLocalSource.insertLeague(localLeague: LocalLeague(id: 6,name: "sport6",logo: "",sport: "football"))
        let countAfter = fakeLocalSource.leagues.count
        XCTAssertEqual(countAfter, countBefore! + 1)
    }
    
    func testCountOfLeagues(){
        let count = favViewModel?.getAllLeagues().count
        XCTAssertEqual(count, fakeLocalSource.leagues.count)
        
    }
    
    func testTheReturnOfDataHasTheSameValues(){
        let nameOfLeague = fakeLocalSource.leagues[0].name
        XCTAssertEqual(favViewModel?.getAllLeagues()[0].name, nameOfLeague)

    }
    
    func testDeleteFromFav(){
        let countBefore = favViewModel?.getAllLeagues().count
        fakeLocalSource.deleteLeague(name: "sport1", id: 1)
        let countAfter = fakeLocalSource.leagues.count
        XCTAssertEqual(countAfter, countBefore! - 1)
    }
    
    func testDeleteLeague(){
        var league: LocalLeague?
        league = favViewModel?.getSelectedLeague(name: "sport1", id: 1)
        XCTAssertEqual(league?.sport,"football")
    }

}
