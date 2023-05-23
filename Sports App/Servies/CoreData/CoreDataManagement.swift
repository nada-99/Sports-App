//
//  CoreDataManagment.swift
//  Sports App
//
//  Created by Nada on 23/05/2023.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataProtocol{
    func insertLeague(localLeague : LocalLeague)
    func getAllLeagues() -> [LocalLeague]
    func deleteLeague(name: String, id: Int)
    func getLeagueFromLocal(name: String, id: Int)  -> LocalLeague?
}

class CoreDataManagement : CoreDataProtocol{
    
    var managedContext: NSManagedObjectContext
    init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    func insertLeague(localLeague: LocalLeague) {
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(localLeague.name, forKey: "name")
        league.setValue(localLeague.sport, forKey: "sport")
        league.setValue(localLeague.logo, forKey: "logo")
        league.setValue(localLeague.id, forKey: "id")
        do{
            try managedContext.save()
            print("Inserting done")
        }catch let error as NSError{
            print("error in adding to favourite: \(error)")
        }
        
    }
    
    func getAllLeagues() -> [LocalLeague] {
        var leaguesList: [LocalLeague] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            for i in leagues{
                let league = LocalLeague(id: i.value(forKey: "id") as? Int, name: i.value(forKey: "name") as? String, logo: i.value(forKey: "logo") as? String, sport: i.value(forKey: "sport") as? String)
                leaguesList.append(league)
            }
            print("all leagues done")
        }catch let error as NSError{
            print("error in fetching all leagues: \(error)")
        }
        
        return leaguesList
    }
    
    func deleteLeague(name: String, id: Int) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        
        let myPredicate = NSPredicate(format: "id == %d", id)
        fetchRequest.predicate = myPredicate
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            print(leagues.count)
            if leagues.count > 0{
                managedContext.delete(leagues[0])
                try managedContext.save()
                print("Delete done")
            }
        }catch let error as NSError{
            print("error in deleteting a league : \(error)")
        }
    }
    
    func getLeagueFromLocal(name: String, id: Int) -> LocalLeague? {
        var leagueList : LocalLeague?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        
        let myPredicate = NSPredicate(format: "name == %@ and id == %d", name, id)
        fetchRequest.predicate = myPredicate
        do{
            let leagues = try managedContext.fetch(fetchRequest)
            if leagues.count > 0{
                let i = leagues[0]
                leagueList = LocalLeague(id: i.value(forKey: "id") as? Int, name: i.value(forKey: "name") as? String, logo: i.value(forKey: "logo") as? String, sport: i.value(forKey: "sport") as? String)
                print("Getting a league")
            }else{
                print("no item")
            }
        }catch let error as NSError{
            print("error in fetching all leagues: \(error)")
        }
        
        return leagueList ?? nil
    }
    
    
}
