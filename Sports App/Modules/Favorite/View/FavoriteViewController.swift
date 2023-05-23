//
//  FavoriteViewController.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import UIKit

class FavoriteViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    
    @IBOutlet weak var leaguesTable: UITableView!
    
    var leagueList = [LocalLeague]()
    var sportName : String?
    var favViewModel : FavoriteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favorites"

        favViewModel = FavoriteViewModel(coreDataProtocol: CoreDataManagement())
        
        favViewModel?.getAllLeagues()
        favViewModel?.refreshFavouriteLeagues = { () in
            DispatchQueue.main.async {
                self.leagueList = self.favViewModel?.leagues ?? []
                self.leaguesTable.reloadData()
            }
        }
        /*favViewModel?.refreshFavouriteLeagues = {
            [weak self] in
            DispatchQueue.main.async {
                self?.leagueList = self?.favViewModel?.leagues ?? []
                self?.leaguesTable.reloadData()
//                if self?.leagues.count == 0{
//                    //imgNoItems.isHidden = false
//
//                    self?.leaguesTable.isHidden = true
//                }else{
//                    imgNoItems.isHidden = true
//                    self?.leaguesTable.isHidden = false
//                }
            }
        }*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let _ = favViewModel?.getAllLeagues()
        
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
        cell.leagueTitle.text = league.name
        let url = URL(string: league.logo ?? "")
        cell.leagueImg?.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguedetails = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
        leaguedetails.nameSport = leagueList[indexPath.section].sport
        leaguedetails.leagueID = leagueList[indexPath.section].id
        leaguedetails.localLeague = LocalLeague(id: leagueList[indexPath.section].id , name: leagueList[indexPath.section].name , sport: sportName)
           self.navigationController?.pushViewController(leaguedetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Delete League", message: "ARE YOU SURE TO DELETE?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default,handler: { [weak self] action in
            
            self?.favViewModel?.deleteLeague(name: self?.leagueList[indexPath.section].name ?? "", id: self?.leagueList[indexPath.section].id ?? 0)
            self?.leagueList.remove(at: indexPath.section)
            self?.leaguesTable.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
