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
    
    static var profile: (name: String, picture: String) = (name: "", picture: "")
    static var overview: (originDate: String, statement: String, personal: [(language: String, days: Int)], work: [(language: String, days: Int)]) = (originDate: "", statement: "", personal: [], work: [])
    static var work: (originDate: String, statement: String, personal: [(language: String, days: Int)], work: [(language: String, days: Int)]) = (originDate: "", statement: "", personal: [], work: [])
    
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
    
    //MARK: Populate Data
    static func populateData(for key: String) {
        if coreDataPopulated() {
            loadProfile()
            loadOverview()
            loadWork()
        }
        else {
            firebaseAll {
                UserDefaults.standard.set(true, forKey: "CoreData")
            }
        }
    }
    
    static func checkFirebaseForReset() {
        firebaseReset() { reset in
            //print("Check Firebase reset: \(reset)")
            if reset {
                UserDefaults.standard.set(false, forKey: "CoreData")
                populateData(for: "all")
            }
        }
    }
    
    //MARK: UserDefaults
    static func coreDataPopulated() -> Bool {
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
        //print("Loading CoreData Profile")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Data.CoreData.Profile)
        let objects = try! managedContext.fetch(fetch) as! [ProfileData]
        if let object = objects.first, let name = object.name, let picture = object.picture {
            profile = (name: name, picture: picture)
        }
    }
    
    //MARK: CoreData Overview
    static func setOverview(originDate: String, statement: String, personal: [String: AnyObject], work: [String: AnyObject]) {
        //print("Setting CoreData Overview")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let overviewEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Overview, in: managedContext)!
        let overview = NSManagedObject(entity: overviewEntity, insertInto: managedContext)
        overview.setValue(originDate, forKeyPath: Constants.Data.Overview.originDate)
        overview.setValue(statement, forKeyPath: Constants.Data.Overview.statement)
        let lists = [personal, work]
        let types = [Constants.Data.Overview.personalProjects, Constants.Data.Overview.workProjects]
        for (i, keyList) in [personal.keys, work.keys].enumerated() {
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
                        project.setValue(overview, forKey: Constants.Data.Overview.manyToOne)
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
        //print("Loading CoreData Overview")
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
                overview = (originDate: originDate, statement: statement, personal: personal, work: work)
            }
        }
    }
    
    //MARK: CoreData Work
    static func setWork(jobs: [(company: String, positions: [(startDate: String, title: String, workCompleted: String)])]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        jobs.forEach { job in
            let workEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Work, in: managedContext)!
            let work = NSManagedObject(entity: workEntity, insertInto: managedContext)
            work.setValue(job.company, forKeyPath: Constants.Data.Work.company)
            job.positions.forEach { positionInfo in
                let newPosition = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.WorkPosition, in: managedContext)!
                let position = NSManagedObject(entity: newPosition, insertInto: managedContext)
                position.setValue(positionInfo.startDate, forKeyPath: Constants.Data.Work.startDate)
                position.setValue(positionInfo.title, forKeyPath: Constants.Data.Work.title)
                position.setValue(positionInfo.workCompleted, forKeyPath: Constants.Data.Work.workCompleted)
                position.setValue(work, forKey: Constants.Data.Work.manyToOne)
            }
        }
        do {
            try managedContext.save()
            loadWork()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadWork() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.Data.CoreData.Work)
        let objects = try! managedContext.fetch(fetch) as! [WorkData]
        objects.forEach { object in
            if  let company = object.company,
                let positions = object.positions?.allObjects as? [WorkPosition] // Set One-to-Many
            {
                var jobs = [(company: String, positions: [(startDate: String, title: String, workCompleted: String)])]
                positions.forEach { position in
                    if  let startDate = position.startDate,
                        let title = position.title,
                        let workCompleted = position.workCompleted
                    {
                        jobs.append((company: company, positions))
                    }
                }
                //overview = (originDate: originDate, statement: statement, personal: personal, work: work)
            }
        }
    }
    
    //MARK: CoreData Delete
    static func deleteCoreData(forEntity entity: String) {
        //print("Deleting CoreData for \(entity)")
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
    
    //MARK: Firebase All
    static func firebaseAll(completion:@escaping () -> Void) {
        //print("startFireBaseAll")
        firebaseProfile()
        firebaseOverview()
        firebaseWork()
        completion()
    }
    
    //MARK: Firebase Profile
    static func firebaseProfile() {
        //print("Firebase Profile has fired")
        Database.database().reference(withPath: Constants.Data.Firebase.profile).observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if  let name = dict[Constants.Data.Profile.name] as? String,
                    let pictureURL = dict[Constants.Data.Profile.picture] as? String
                {
                    if coreDataPopulated() {
                        //print("coreDataPopulated @ Profile")
                        deleteCoreData(forEntity: Constants.Data.CoreData.Profile)
                    }
                    //print("coreDataNOTPopulated @ Profile")
                    setProfile(name: name, picture: pictureURL)
                }
            }
        })
    }
    
    //MARK: Firebase Overview
    static func firebaseOverview() {
        Database.database().reference(withPath: Constants.Data.Firebase.overview).observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if  let originDate = dict[Constants.Data.Overview.originDate] as? String,
                    let personalProjects = dict[Constants.Data.Overview.personalProjects] as? [String: AnyObject],
                    let workProjects = dict[Constants.Data.Overview.workProjects] as? [String: AnyObject],
                    let statement = dict[Constants.Data.Overview.statement] as? String
                {
                    if coreDataPopulated() {
                        //print("coreDataPopulated @ Overview")
                        deleteCoreData(forEntity: Constants.Data.CoreData.Overview)
                        deleteCoreData(forEntity: Constants.Data.CoreData.OverviewProject)
                    }
                    setOverview(originDate: originDate, statement: statement, personal: personalProjects, work: workProjects)
                }
            }
        })
    }
    
    //MARK: Firebase Work
    static func firebaseWork() {
        Database.database().reference(withPath: Constants.Data.Firebase.work).observeSingleEvent(of: .value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                var jobs: [(company: String, positions: [(startDate: String, title: String, workCompleted: String)])] = []
                dict.keys.forEach { key in
                    if  let job = dict[key] as? [String: AnyObject],
                        let company = job[Constants.Data.Work.company] as? String,
                        let positions = job[Constants.Data.Work.positions] as? [String: AnyObject]
                    {
                        var positionsList: [(startDate: String, title: String, workCompleted: String)] = []
                        positions.keys.forEach { key in
                            if  let position = positions[key],
                                let startDate = position[Constants.Data.Work.startDate] as? String,
                                let title = position[Constants.Data.Work.title] as? String,
                                let workCompleted = position[Constants.Data.Work.workCompleted] as? String
                            {
                                positionsList.append((startDate: startDate, title: title, workCompleted: workCompleted))
                            }
                        }
                        jobs.append((company: company, positions: positionsList))
                    }
                }
                if coreDataPopulated() {
                    //print("coreDataPopulated @ Overview")
                    deleteCoreData(forEntity: Constants.Data.CoreData.Work)
                }
                setWork(jobs: jobs)
            }
        })
    }

}

