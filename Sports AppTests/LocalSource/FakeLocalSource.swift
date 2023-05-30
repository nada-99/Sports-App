//
//  FakeLocalSource.swift
//  Sports AppTests
//
//  Created by Nada on 30/05/2023.
//

import Foundation
@testable import Sports_App

class FackeLocalSource: CoreDataProtocol{

    var leagues: [LocalLeague]!
    init(){
        leagues = [ LocalLeague(id: 1,name: "sport1",logo: "",sport: "football"),
                    LocalLeague(id: 2,name: "sport2",logo: "",sport: "football"),
                    LocalLeague(id: 3,name: "sport3",logo: "",sport: "football"),
                    LocalLeague(id: 4,name: "sport4",logo: "",sport: "football"),
                    LocalLeague(id: 5,name: "sport5",logo: "",sport: "football")]
                
    }
    
    func insertLeague(localLeague: Sports_App.LocalLeague) {
        leagues.append(localLeague)
    }
    
    
    func getAllLeagues() -> [Sports_App.LocalLeague] {
        return leagues
    }
    
    func deleteLeague(name: String, id: Int) {
        for item in 0..<leagues.count{
            if  leagues[item].id == id{
                leagues.remove(at: item)
                break
            }
        }
    }
    
    func getLeagueFromLocal(name: String, id: Int) -> Sports_App.LocalLeague? {
        for item in leagues{
            if item.id == id{
                return item
            }
        }
        return  nil
    }
    
    
    
}
