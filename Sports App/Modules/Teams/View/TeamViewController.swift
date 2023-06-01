//
//  TeamViewController.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import UIKit

class TeamViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    var teamKey : Int?
    var passedTeam : [Teams]?
    var playersList = [Player]()
    var teamDetailsViewModel: TeamDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playersTable.delegate = self
        playersTable.dataSource = self
        
        teamDetailsViewModel = TeamDetailsViewModel()
        teamDetailsViewModel?.getTeamDetails(teamId: teamKey!)
        teamDetailsViewModel?.bindListOfTeamViewController = { () in
            DispatchQueue.main.async {
                self.passedTeam = self.teamDetailsViewModel?.teamList ?? []
                self.playersList = self.passedTeam?[0].players ?? []
                let url = URL(string: self.passedTeam?[0].team_logo ?? "")
                self.teamImg.kf.setImage(with: url , placeholder: UIImage(named: "cub"))
                self.teamName.text = self.passedTeam?[0].team_name
                self.coachName.text = self.passedTeam?[0].coaches?[0].coach_name
                self.playersTable.reloadData()
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
    
        let player = playersList[indexPath.section]
        cell.memberName.text = player.player_name
        let url = URL(string: player.player_image ?? "")
        cell.memberImg?.kf.setImage(with: url , placeholder: UIImage(named: "member"))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true)
    }
}
