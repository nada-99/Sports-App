//
//  LeagueDetailsViewModel.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import Foundation

class LeagueDetailsViewModel{
    
    var bindUpComingListToLeagueDetails :  (()->()) = {}
    var bindLatestEventListToLeagueDetails :  (()->()) = {}
    var bindTeamsListToLeagueDetails :  (()->()) = {}
    
    var upComingList  : [UpCommingEvent]? {
        didSet {
            bindUpComingListToLeagueDetails()
        }
    }
    var latestEventsList : [LatestEvents]?{
        didSet{
            bindLatestEventListToLeagueDetails()
        }
    }
    var teamsList : [Teams]?{
        didSet{
            bindTeamsListToLeagueDetails()
        }
    }
    
    var sport: String?
    var leagueId: Int?
    var coreData : CoreDataProtocol
    
    init(sport: String, leagueId: Int, coreData : CoreDataProtocol) {
        self.coreData = coreData
        self.sport = sport
        self.leagueId = leagueId
    }
    
    func getUpccoming(sportName :  String,  leagueId: Int) {
        NetworkManager.getUpComingEvents(sportName: sportName, leagueId: leagueId, completionHandler: { result in
            self.upComingList = result?.result
            
        })
    }
    func getLastesEvent(sportName: String, leagueId: Int){
        NetworkManager.getLatestEvents(sportName: sportName, leagueId: leagueId, completionHandler: { result in
            self.latestEventsList = result?.result
            
        })
    }
    func getTeams(sportName: String, leagueId: Int){
        NetworkManager.getTeams(sportName: sportName, leagueId: leagueId, completionHandler: { result in
            self.teamsList = result?.result
        })
    }
  
    func deleteLeague(name: String, id: Int){
        coreData.deleteLeague(name: name, id: id)
    }
    
    func getSelectedLeague(name: String, id: Int) -> LocalLeague?{
        return coreData.getLeagueFromLocal(name: name, id: id) ?? nil
    }
    
    func addToFav(localLeague: LocalLeague){
        coreData.insertLeague(localLeague: localLeague)
    }
}

