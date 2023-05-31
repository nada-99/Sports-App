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
        
        let noFavImg = UIImageView()
        noFavImg.image = UIImage(named: "noFav")
        noFavImg.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(noFavImg)
        noFavImg.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        noFavImg.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        noFavImg.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
        noFavImg.heightAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true


        favViewModel = FavoriteViewModel(coreDataProtocol: CoreDataManagement())
        
        favViewModel?.getAllLeagues()
        favViewModel?.refreshFavouriteLeagues = { () in
            DispatchQueue.main.async {
                self.leagueList = self.favViewModel?.leagues ?? []
                self.leaguesTable.reloadData()
                if self.leagueList.count == 0{
                    noFavImg.isHidden = false
                    self.leaguesTable.isHidden = true
                }else{
                    noFavImg.isHidden = true
                    self.leaguesTable.isHidden = false
                }
            }
        }
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
        if !CheckInternetConnection.isInternetAvailable(){
            showAlert()
        }else{
            let leaguedetails = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetails") as! LeagueDetailsViewController
            leaguedetails.nameSport = leagueList[indexPath.section].sport
            leaguedetails.leagueID = leagueList[indexPath.section].id
            leaguedetails.localLeague = LocalLeague(id: leagueList[indexPath.section].id , name: leagueList[indexPath.section].name , sport: sportName)
            self.navigationController?.pushViewController(leaguedetails, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let alert : UIAlertController = UIAlertController(title: "Delete League", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { [weak self] action in
            
            self?.favViewModel?.deleteLeague(name: self?.leagueList[indexPath.section].name ?? "", id: self?.leagueList[indexPath.section].id ?? 0)
            self?.leagueList.remove(at: indexPath.section)
            self?.leaguesTable.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
