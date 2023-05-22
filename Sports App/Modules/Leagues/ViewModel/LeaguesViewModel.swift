//
//  LeaguesViewModel.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import Foundation

class LeagueViewModel {
    var bindListToLeagueTableViewController : (()->()) = {}
   
    var leagueList : [League]? {
        didSet {
            bindListToLeagueTableViewController()
        }
    }
    
    func getLeagues (sportName : String) {
        NetworkManager.getAllLeagues(sportName: sportName, completionHandler: {
            result in self.leagueList = result?.result
        })
    }
}
