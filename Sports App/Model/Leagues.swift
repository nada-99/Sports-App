//
//  Leagues.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import Foundation

class League : Decodable {
    var league_key:Int?
    var league_name:String?
    var league_logo:String?
    var country_key:Int?
    var country_name:String?
}

class LeagueRoot : Decodable {
    var result : [League]
    var success : Int?
}
