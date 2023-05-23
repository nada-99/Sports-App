//
//  TeamViewModel.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import Foundation

class TeamDetailsViewModel{
    var bindListOfTeamViewController : (()->()) = {}
   
    var teamList : [Teams]? {
        didSet {
            bindListOfTeamViewController()
        }
    }
    
    func getTeamDetails(teamId: Int) {
        NetworkManager.getTeamDetails(teamId: teamId, completionHandler: {
            result in self.teamList = result?.result
        })
    }
}
