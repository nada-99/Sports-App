//
//  NetworkManager.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//


import Foundation
import Alamofire

let apiKey = "1536c6654ca2ed6d626e25f4a41af74352337ef236f34290eabe082a20ca8510"

protocol NetworkServicesProtocol{
    
    static func getAllLeagues(sportName: String , completionHandler: @escaping (LeagueRoot?) -> Void)
    
    static func getUpComingEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (UpComingRoot?) -> Void )
    
    static func getLatestEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (LatestEventRoot?) -> Void )
    
    static func getTeams(sportName: String ,leagueId: Int , completionHandler: @escaping (TeamsRoot?) -> Void )
    
    static func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsRoot?) -> Void )
    
}

class NetworkManager : NetworkServicesProtocol{

    static func getAllLeagues(sportName: String, completionHandler: @escaping (LeagueRoot?) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(apiKey)"

        Alamofire.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(LeagueRoot.self, from: data)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    static func getUpComingEvents(sportName: String, leagueId: Int, completionHandler: @escaping (UpComingRoot?) -> Void) {

        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueId)&from=2023-05-09&to=2024-02-09&APIkey=\(apiKey)"

        Alamofire.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(UpComingRoot.self, from: data)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    static func getLatestEvents(sportName: String, leagueId: Int, completionHandler: @escaping (LatestEventRoot?) -> Void) {
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueId)&from=2023-04-09&to=2024-02-09&APIkey=\(apiKey)"

        Alamofire.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(LatestEventRoot.self, from: data)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    static func getTeams(sportName: String, leagueId: Int, completionHandler: @escaping (TeamsRoot?) -> Void) {
        
        let urlString = "https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=\(apiKey)"

        Alamofire.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(TeamsRoot.self, from: data)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }
    
    static func getTeamDetails(teamId: Int, completionHandler: @escaping (TeamsRoot?) -> Void) {
        let urlString = "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=\(teamId)&APIkey=\(apiKey)"

        Alamofire.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(TeamsRoot.self, from: data)
                    completionHandler(result)
                } catch let error {
                    print(error.localizedDescription)
                    completionHandler(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                completionHandler(nil)
            }
        }
    }

}
