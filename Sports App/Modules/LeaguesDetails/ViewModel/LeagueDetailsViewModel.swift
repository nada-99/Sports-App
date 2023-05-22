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
  
}

