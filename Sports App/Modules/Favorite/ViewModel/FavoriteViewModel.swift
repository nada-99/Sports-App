//
//  FavoriteViewModel.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import Foundation

class FavoriteViewModel{
    
    var refreshFavouriteLeagues: (()->()) = {}
    var leagues: [LocalLeague]?{
        didSet{
            refreshFavouriteLeagues()
        }
    }
    var getFavouriteLeague: (()->()) = {}
    var league: LocalLeague?{
        didSet{
            getFavouriteLeague()
        }
    }
    
    var coreDataProtocol : CoreDataProtocol
    init( coreDataProtocol : CoreDataProtocol) {
        self.coreDataProtocol = coreDataProtocol
    }
    
    func getAllLeagues() -> [LocalLeague]{
        leagues = coreDataProtocol.getAllLeagues()
        return leagues ?? []
    }
    
    func deleteLeague(name: String, id: Int){
        coreDataProtocol.deleteLeague(name: name, id: id)
        let _ = getAllLeagues()
    }
    
    func getSelectedLeague(name: String, id: Int) -> LocalLeague{
        league = coreDataProtocol.getLeagueFromLocal(name: name, id: id)
        return league!
    }
    
}
