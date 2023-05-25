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
    
    var leagueDetailVM : LeagueDetailsViewModel?
    var localLeague : LocalLeague!
    var img = UIImage(systemName: "heart")
    var isFavorite = false

    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var leguesCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        leguesCollection.layer.cornerRadius = 40
        
        let layout = UICollectionViewCompositionalLayout{index, environment in
            if index == 0{
                print("upcoming")
                return self.drawUpComingSection()
            }else if index == 1 {
                print("latest")
                return self.drawLatestSection()
                
            }else{
                print("teams")
                return self.drawTeamsSection()
            }
        }
        leguesCollection.setCollectionViewLayout(layout, animated: true)
        
        leagueDetailVM = LeagueDetailsViewModel(sport: nameSport!, leagueId: leagueID!, coreData: CoreDataManagement())
        
        leagueDetailVM?.getUpccoming(sportName: nameSport!, leagueId: leagueID!)
        leagueDetailVM?.bindUpComingListToLeagueDetails = { () in
            DispatchQueue.main.async {
                self.upComingList = self.leagueDetailVM?.upComingList ?? []
                self.leguesCollection.reloadData()
                print("upComing = \(self.upComingList.count)")
            }
        }
        leagueDetailVM?.getLastesEvent(sportName: nameSport!, leagueId: leagueID!)
        leagueDetailVM?.bindLatestEventListToLeagueDetails = { () in
            DispatchQueue.main.async {
                self.latestEventsList = self.leagueDetailVM?.latestEventsList ?? []
                self.leguesCollection.reloadData()
                print("latest = \(self.latestEventsList.count)")
            }
        }
        leagueDetailVM?.getTeams(sportName: nameSport!, leagueId: leagueID!)
        leagueDetailVM?.bindTeamsListToLeagueDetails = { () in
            DispatchQueue.main.async {
                self.teamsList = self.leagueDetailVM?.teamsList ?? []
                self.leguesCollection.reloadData()
                print("teams = \(self.teamsList.count)")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favBtn.setImage(img, for: .normal)
        if  img == UIImage(systemName: "heart") {
            let isFav =  leagueDetailVM?.getSelectedLeague(name: localLeague.name!, id: localLeague.id!)
            if isFav == nil {
                favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                isFavorite = false
            }else{
                favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                isFavorite = true
            }
        }
    }
    
    func drawUpComingSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)) // Set the header size
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        
        return section
    }
    func drawLatestSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension:  .absolute(140))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 16)
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
        
    }
    func drawTeamsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension:  .absolute(140))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 16, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return upComingList.count
        }else if section == 1 {
            return latestEventsList.count
        }else{
            return teamsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
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
            return cell
        }else if indexPath.section == 1{
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
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamCollectionViewCell
            let team = teamsList[indexPath.row]
            let url = URL(string: team.team_logo ?? "")
            cell.teamImg?.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
            cell.teamTitle.text = team.team_name
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if  upComingList.count == 0 && latestEventsList.count == 0 {
//            collectionDetails.isHidden = true
//            imgNoItems.isHidden = false
            print("no data")
        }else{
//            imgNoItems.isHidden = true
//            collectionDetails.isHidden = false
            print("hii data")
        }
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionHeader", for: indexPath) as! HeaderCollectionReusableView
            
            if indexPath.section == 0 {
                
                header.sectionHeader.text = "Up Coming Events"
            }else if indexPath.section == 1{
                header.sectionHeader.text = "Latest Results"
            }else{
                header.sectionHeader.text = "Teams"
            }
            
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2{
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "teamDetails") as! TeamViewController
            teamDetails.teamKey = teamsList[indexPath.row].team_key
            self.navigationController?.pushViewController(teamDetails, animated: true)
            print(teamsList[indexPath.row].team_key)
        }
    }
    
    
    @IBAction func addToFav(_ sender: Any) {
                
        isFavorite = !isFavorite
        
        if isFavorite {
            let img = UIImage(systemName: "heart.fill")
            leagueDetailVM?.addToFav(localLeague: localLeague)
            favBtn.setImage(img, for: .normal)
        } else {
            let alert : UIAlertController = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { [weak self] action in
                let img = UIImage(systemName: "heart")
                self?.favBtn.setImage(img, for: .normal)
                self?.leagueDetailVM?.deleteLeague(name: self?.localLeague.name ?? "", id: (self?.localLeague.id ?? 0))
                
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
