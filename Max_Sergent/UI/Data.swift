//
//  Data.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import FirebaseStorage

struct Data {
    
    static var profile: (name: String, picture: String) = (name: "Ivan", picture: "UGLY")
    static var overview: (originDate: String, statement: String, personal: [(language: String, days: Int)], work: [(language: String, days: Int)]) = (originDate: "01/01/2001", statement: "Think different.", personal: [], work: [])
    
    static let experience: [String : [(position: String, work: String)]] =
        ["BEA":
            [(position: "Analyst", work: "I was lucky — I found what I loved to do early in life. Woz and I started Apple in my parents’ garage when I was 20. We worked hard, and in 10 years Apple had grown from just the two of us in a garage into a $2 billion company with over 4,000 employees."),
             (position: "Economist", work: "We had just released our finest creation — the Macintosh — a year earlier, and I had just turned 30. And then I got fired. How can you get fired from a company you started? Well, as Apple grew we hired someone who I thought was very talented to run the company with me, and for the first year or so things went well. ")],
        "Toggle":
            [(position: "Co-Founder", work: "But then our visions of the future began to diverge and eventually we had a falling out. When we did, our Board of Directors sided with him. So at 30 I was out. And very publicly out. What had been the focus of my entire adult life was gone, and it was devastating.")]
        ]
     
//    func imageStuff() {
//        if let success = UIImage(named: "placeholder.png")?.saveImage(as: "placeholder") {
//
//        }
//        if let image = loadImage(named: "placeholder") {
//            print("loaded")
//            print(image)
//        }
//    }
//
//    func loadImage(named: String) -> UIImage? {
//        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
//        }
//        return nil
//    }
//
//    func deleteImages() {
//        let fileManager = FileManager.default
//        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        do {
//            try fileManager.removeItem(at: myDocuments)
//        } catch {
//            return
//        }
//    }
//
//    func contentsOfDocumentsDirectory() {
//        do {
//            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let docs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [], options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
//            print(docs)
//        } catch {
//            print(error)
//        }
//    }
    
    //MARK: UserDefaults
    static func coreDataPopulated() -> Bool {
        print("Has coreDataPopulated? \(UserDefaults.standard.bool(forKey: "CoreData"))")
        return UserDefaults.standard.bool(forKey: "CoreData")
    }
    
    //MARK: CoreData Profile
    static func setProfile(name: String, picture: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let profileEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Profile, in: managedContext)!
        let profile = NSManagedObject(entity: profileEntity, insertInto: managedContext)
        profile.setValue(name, forKeyPath: Constants.Data.Profile.name)
        profile.setValue(picture, forKeyPath: Constants.Data.Profile.picture)
        do {
            try managedContext.save()
            loadProfile()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadProfile() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Data.CoreData.Profile)
        let objects = try! managedContext.fetch(fetch) as! [ProfileData]
        if let object = objects.first {
            if  let name = object.name,
                let picture = object.picture
            {
                profile = (name: name, picture: picture)
            }
        }
    }
    
    //MARK: CoreData Overview
    static func setOverview(originDate: String, statement: String, personalProjects: [String: AnyObject], workProjects: [String: AnyObject]) {
        print("Setting CoreData Overview")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let overviewEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Overview, in: managedContext)!
        let overview = NSManagedObject(entity: overviewEntity, insertInto: managedContext)
        overview.setValue(originDate, forKeyPath: Constants.Data.Overview.originDate)
        overview.setValue(statement, forKeyPath: Constants.Data.Overview.statement)
        
        let lists = [workProjects, personalProjects]
        let types = [Constants.Data.Overview.workProjects, Constants.Data.Overview.personalProjects]
        for (i, keyList) in [workProjects.keys, personalProjects.keys].enumerated() {
            keyList.forEach { key in
                 if let dict = lists[i][key] as? [String: AnyObject] {
                    if  let language = dict[Constants.Data.Overview.language] as? String,
                        let days = dict[Constants.Data.Overview.days] as? Int
                    {
                        let newProject = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.OverviewProject, in: managedContext)!
                        let project = NSManagedObject(entity: newProject, insertInto: managedContext)
                        project.setValue(types[i], forKey: Constants.Data.Overview.type)
                        project.setValue(language, forKey: Constants.Data.Overview.language)
                        project.setValue(days, forKey: Constants.Data.Overview.days)
                        project.setValue(overview, forKey: "overview")
                    }
                 }
            }
        }
        do {
            try managedContext.save()
            loadOverview()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadOverview() {
        print("Loading CoreData Overview")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Data.CoreData.Overview)
        let objects = try! managedContext.fetch(fetch) as! [OverviewData]
        objects.forEach { object in
            if  let originDate = object.originDate,
                let statement = object.statement,
                let projects = object.projects?.allObjects as? [OverviewProject] // Set One-to-Many
            {
                var personal: [(language: String, days: Int)] = []
                var work: [(language: String, days: Int)] = []
                projects.forEach { project in
                    if project.type == Constants.Data.Overview.personalProjects {
                        personal.append((language: project.language!, days: Int(project.days)))
                    }
                    else if project.type == Constants.Data.Overview.workProjects {
                        work.append((language: project.language!, days: Int(project.days)))
                    }
                }
                print(overview)
                overview = (originDate: originDate, statement: statement, personal: personal, work: work)
                print(overview)
            }
        }
    }
    
    //MARK: CoreData Delete
    static func deleteCoreData(forEntity entity: String) {
        print("Deleting CoreData for \(entity)")
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print ("There was an error")
        }
    }
    
    //MARK: Reload Firebase
    static func reloadFirebase(for key: String) {
        firebaseReset() { reset in
            if reset {
                //firebaseProfile()
                firebaseOverview()
                //firebaseWork()
                UserDefaults.standard.set(true, forKey: "CoreData")
            }
            else {
                print("Do not reset from Firebase")
                //loadProfile()
                loadOverview()
            }
        }
    }
    
    //MARK: Firebase Reset
    static func firebaseReset(completionHandler:@escaping (Bool) -> ()) {
        Database.database().reference(withPath: Constants.Data.Firebase.reset).observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if let reset = dict[Constants.Data.Reset.proceed] as? Bool {
                    completionHandler(reset)
                }
                else {
                    completionHandler(false)
                    print("Error: snapshot.value['proceed'] not convertible to Bool")
                }
            }
            else {
                completionHandler(false)
                print("Error: snapshot.value not convertible to [String: AnyObject]")
            }
        })
    }
    
    //MARK: Firebase Profile
    static func firebaseProfile() {
        print("Firebase Profile has fired")
        Database.database().reference(withPath: Constants.Data.Firebase.profile).observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if  let name = dict[Constants.Data.Profile.name] as? String,
                    let pictureURL = dict[Constants.Data.Profile.picture] as? String
                {
                    if coreDataPopulated() {
                        print("coreDataPopulated @ Profile")
                        deleteCoreData(forEntity: Constants.Data.CoreData.Profile)
                        setProfile(name: name, picture: pictureURL)
                    }
                    else {
                        print("coreDataNOTPopulated @ Profile")
                        setProfile(name: name, picture: pictureURL)
                    }
                }
            }
        })
    }
    
    //MARK: Firebase Overview
    static func firebaseOverview() {
        Database.database().reference(withPath: Constants.Data.Firebase.overview).observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if  let originDate = dict[Constants.Data.Overview.originDate] as? String,
                    let personalProjects = dict[Constants.Data.Overview.personalProjects] as? [String: AnyObject],
                    let workProjects = dict[Constants.Data.Overview.workProjects] as? [String: AnyObject],
                    let statement = dict[Constants.Data.Overview.statement] as? String
                {
                    //print("-- OVERVIEW ------")
                    //print(originDate,"\n",statement)
//                    personalProjects.keys.forEach { key in
//                        if let dict = personalProjects[key] as? [String: AnyObject] {
//                            if  let language = dict[Constants.Data.Overview.language] as? String,
//                                let days = dict[Constants.Data.Overview.days] as? Int
//                            {
//                                //print("\(language) | \(days)")
//                            }
//                        }
//                    }
//                    workProjects.keys.forEach { key in
//                        if let dict = workProjects[key] as? [String: AnyObject] {
//                            if  let language = dict[Constants.Data.Overview.language] as? String,
//                                let days = dict[Constants.Data.Overview.days] as? Int
//                            {
//                                //print("\(language) | \(days)")
//                            }
//                        }
//                    }
                    if coreDataPopulated() {
                        print("coreDataPopulated @ Overview")
                        deleteCoreData(forEntity: Constants.Data.CoreData.Overview)
                        deleteCoreData(forEntity: Constants.Data.CoreData.OverviewProject)
                    }
                    else {
                        print("coreDataNOTPopulated @ Overview")
                    }
                    setOverview(originDate: originDate, statement: statement, personalProjects: personalProjects, workProjects: workProjects)
                }
            }
        })
    }
    
    //MARK: Firebase Work
    static func firebaseWork() {
        Database.database().reference(withPath: Constants.Data.Firebase.work).observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                //print("-- WORK ------")
                dict.keys.forEach { key in
                    if let job = dict[key] as? [String: AnyObject] {
                        if  let company = job[Constants.Data.Work.company] as? String,
                            let positions = job[Constants.Data.Work.positions] as? [String: AnyObject]
                        {
                            positions.keys.forEach { key in
                                if let position = positions[key] {
                                    if  let startDate = position[Constants.Data.Work.startDate] as? String,
                                        let title = position[Constants.Data.Work.title] as? String,
                                        let workCompleted = position[Constants.Data.Work.workCompleted] as? String
                                    {
                                        //print(company)
                                        //print(startDate," | ",title,"\n",workCompleted)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        })
    }
}

/*
func updateCoreData(for attribute: String, from entity: String, oldValue: String, newValue: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    //fetchRequest.predicate = NSPredicate(format: "userID = %@ AND name = %&", argumentArray: value)
    //fetchRequest.predicate = NSPredicate(format: "userID == %@", oldValue)
    fetchRequest.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", attribute, oldValue)
    do {
        let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        if results?.count != 0 { // Atleast one was returned
            // In my case, I only updated the first item in results
            //print("results: \(results![0])")
            results![0].setValue(newValue, forKey: attribute)
        }
    }
    catch {print("Fetch Failed: \(error)")}
    do {
        try managedContext.save()
    }
    catch {print("Saving Core Data Failed: \(error)")}
}

func createWallet(for user: String, coins: [String]) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    fetchRequest.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", "name", user)
    do {
        let results = try managedContext.fetch(fetchRequest) as? [NSManagedObject]
        if results?.count != 0 {
            //print("results: \(results![0])")
            let person = results![0]
            let definedCoin = NSEntityDescription.entity(forEntityName: "Coin", in: managedContext)!
            let coin1 = NSManagedObject(entity: definedCoin, insertInto: managedContext)
            coin1.setValue(coins[0], forKey: "symbol")
            coin1.setValue(coins[1], forKey: "walletID")
            coin1.setValue(person, forKey: "person")
        }
    }
    catch {print("Fetch Failed: \(error)")}
    do {
        try managedContext.save()
    }
    catch {print("Saving Core Data Failed: \(error)")}
}
*/
