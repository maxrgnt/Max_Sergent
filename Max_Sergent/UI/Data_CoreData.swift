//
//  Data_CoreData.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/30/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol DataDelegate {
    func reloadWorkTable()
}

extension Data {
    
    static var customDelegate : DataDelegate!
    
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
    static func setWork(workData: [String: AnyObject]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        workData.keys.forEach { companyKey in
            let workEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Work, in: managedContext)!
            let work = NSManagedObject(entity: workEntity, insertInto: managedContext)
            
            if  let job = workData[companyKey] as? [String: AnyObject],
                let company = job[Constants.Data.Work.company] as? String,
                let positions = job[Constants.Data.Work.positions] as? [String: AnyObject]
            {
                work.setValue(company, forKeyPath: Constants.Data.Work.company)
                work.setValue(companyKey, forKeyPath: Constants.Data.Work.key)
                positions.keys.forEach { positionKey in
                    if  let position = positions[positionKey],
                        let startDate = position[Constants.Data.Work.startDate] as? String,
                        let title = position[Constants.Data.Work.title] as? String,
                        let workCompleted = position[Constants.Data.Work.workCompleted] as? String
                    {
                        let x = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.WorkPosition, in: managedContext)!
                        let newPosition = NSManagedObject(entity: x, insertInto: managedContext)
                        newPosition.setValue(positionKey, forKeyPath: Constants.Data.Work.key)
                        newPosition.setValue(startDate, forKeyPath: Constants.Data.Work.startDate)
                        newPosition.setValue(title, forKeyPath: Constants.Data.Work.title)
                        newPosition.setValue(workCompleted, forKeyPath: Constants.Data.Work.workCompleted)
                        newPosition.setValue(work, forKey: Constants.Data.Work.manyToOne)
                    }
                    else {
                        print("ERROR: Could not access dictionary using positionKey in setWork")
                    }
                }
            }
            else {
                print("ERROR: Could not access dictionary using jobKey in firebaseWork")
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
        work = [:]
        objects.forEach { object in
            if  let companyKey = object.key,
                let company = object.company,
                let positions = object.positions?.allObjects as? [WorkPosition] // Set One-to-Many
            {
                var positionsList: [String: AnyObject] = [:]
                positions.forEach { object in
                    if  let positionKey = object.key,
                        let startDate = object.startDate,
                        let title = object.title,
                        let workCompleted = object.workCompleted
                    {
                        positionsList[positionKey] = [Constants.Data.Work.startDate: startDate,
                                                      Constants.Data.Work.title: title,
                                                      Constants.Data.Work.workCompleted: workCompleted] as AnyObject
                    }
                    else {
                        print("ERROR: Could not access dictionary using positionKey in loadWork")
                    }
                }
                work[companyKey] = [Constants.Data.Work.company: company,
                                    Constants.Data.Work.positions: positionsList] as AnyObject
            }
            else {
                print("ERROR: Could not company or positions in loadWork")
            }
        }
        self.customDelegate.reloadWorkTable()
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

    
}

