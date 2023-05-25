//
//  SportsViewController.swift
//  Sports App
//
//  Created by Nada on 22/05/2023.
//

import UIKit

class SportsViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sportsCollection: UICollectionView!
    
    var sportsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sportsCollection.dataSource = self
        sportsCollection.delegate = self
        
        sportsArray = ["FootBall", "BasketBall", "Cricket", "Tennis"]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width/2 - 10), height: 250)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportType", for: indexPath) as! SportsCollectionViewCell

        cell.sportImg.image = UIImage(named: sportsArray[indexPath.row])
        cell.sportTitle.text = sportsArray[indexPath.row]
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !CheckInternetConnection.isInternetAvailable(){
            showAlert()
        }else{
            let leagueViewController = self.storyboard?.instantiateViewController(withIdentifier: "leagues") as! LeaguesViewController
            leagueViewController.sportName = sportsArray[indexPath.row].lowercased()
                self.navigationController?.pushViewController(leagueViewController, animated: true)
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
