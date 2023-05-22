//
//  LeagueDetailsViewController.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var nameSport : String?
    var leagueID : Int?
    var upComingList = [UpCommingEvent]()
    var latestEventsList = [LatestEvents]()
    var teamsList = [Teams]()

    @IBOutlet weak var upComingCollection: UICollectionView!
    
    @IBOutlet weak var lastestCollection: UICollectionView!
    
    @IBOutlet weak var teamsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("id is \(String(describing: leagueID))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let leagueDetailVM = LeagueDetailsViewModel()
        
        leagueDetailVM.getUpccoming(sportName: nameSport!, leagueId: leagueID!)
        leagueDetailVM.bindUpComingListToLeagueDetails = { () in
            DispatchQueue.main.async {
                self.upComingList = leagueDetailVM.upComingList ?? []
                self.upComingCollection.reloadData()
            }
        }
        leagueDetailVM.getLastesEvent(sportName: nameSport!, leagueId: leagueID!)
        leagueDetailVM.bindLatestEventListToLeagueDetails = { () in
            DispatchQueue.main.async {
                self.latestEventsList = leagueDetailVM.latestEventsList ?? []
                self.lastestCollection.reloadData()
            }
        }
        leagueDetailVM.getTeams(sportName: nameSport!, leagueId: leagueID!)
        leagueDetailVM.bindTeamsListToLeagueDetails = { () in
            DispatchQueue.main.async {
                self.teamsList = leagueDetailVM.teamsList ?? []
                self.teamsCollection.reloadData()
            }
        }
        //checkIfThereIsNoEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.upComingCollection {
            return upComingList.count
        }else if collectionView == self.lastestCollection{
            return latestEventsList.count
        }
        return teamsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.upComingCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingCell
            let upComing = upComingList[indexPath.row]
            let url = URL(string: upComing.home_team_logo ?? "")
            cell.homeTeamImg?.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
            let url2 = URL(string: upComing.away_team_logo ?? "")
            cell.awayTeamImg?.kf.setImage(with: url2 , placeholder: UIImage(named: "cub"))
            cell.homeTeamTitle.text = upComing.event_home_team
            cell.awayTeamTitle.text = upComing.event_away_team
            cell.dateLabel.text = upComing.event_date
            cell.timeLabel.text = upComing.event_time
        }else if collectionView == self.lastestCollection{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastestCell", for: indexPath) as! LastestEventsCell
            let lastEvent = latestEventsList[indexPath.row]
            let url = URL(string: lastEvent.home_team_logo ?? "")
            cell.homeTeamImg?.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
            let url2 = URL(string: lastEvent.away_team_logo ?? "")
            cell.awayTeamImg?.kf.setImage(with: url2 , placeholder: UIImage(named: "cub"))
            cell.homeTeamTitle.text = lastEvent.event_home_team
            cell.awayTeamTitle.text = lastEvent.event_away_team
            cell.dateLabel.text = lastEvent.event_date
            cell.timeLabel.text = lastEvent.event_time
            cell.finalResult.text = lastEvent.event_final_result
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCell
        let team = teamsList[indexPath.row]
        let url = URL(string: team.team_logo ?? "")
        cell.teamImg?.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
        cell.teamName.text = team.team_name
        return cell
    }
    

}
