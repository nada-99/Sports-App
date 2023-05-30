//
//  LeaguesViewController.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import UIKit
import Kingfisher

class LeaguesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var leagueList = [League]()
    var sportName : String?
    var leagueViewModel : LeagueViewModel?
    @IBOutlet weak var leaguesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Leagues"
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        
        leagueViewModel = LeagueViewModel()
        leagueViewModel?.getLeagues(sportName: sportName!)
        leagueViewModel?.bindListToLeagueTableViewController = { () in
            DispatchQueue.main.async {
                self.leagueList = self.leagueViewModel?.leagueList ?? []
                self.leaguesTable.reloadData()
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return leagueList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Leagues", for: indexPath) as! LeaguesCustomCell
    
        let league = leagueList[indexPath.section]
        cell.leagueTitle.text = league.league_name
        let url = URL(string: league.league_logo ?? "")
        cell.leagueImg?.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguedetails = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        leaguedetails.nameSport = sportName
        leaguedetails.leagueID = leagueList[indexPath.section].league_key
        leaguedetails.localLeague = LocalLeague(id: leagueList[indexPath.section].league_key , name: leagueList[indexPath.section].league_name , logo: leagueList[indexPath.section].league_logo, sport: sportName)
        self.navigationController?.pushViewController(leaguedetails, animated: true)
        
        print("sfsdfdfsdf"+(sportName ?? ""))
    }

}
