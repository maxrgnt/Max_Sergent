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
    func reloadProfile()
    func reloadWork()
    func reloadOverview()
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
        guard let object = objects.first, let name = object.name, let picture = object.picture else {
            print("Error: loadProfile - [object, name, picture] not found in ProfileData")
            return
        }
        profile = (name: name, picture: picture)
        self.customDelegate.reloadProfile()
    }
    
    //MARK: CoreData Overview
    static func setOverview(overviewData: [String: AnyObject]) {
        //print("Setting CoreData Overview")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let overviewEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Overview, in: managedContext)!
        let overview = NSManagedObject(entity: overviewEntity, insertInto: managedContext)
        guard let originDate = overviewData[Constants.Data.Overview.originDate] as? String,
              let statement = overviewData[Constants.Data.Overview.statement] as? String,
              let personal = overviewData[Constants.Data.Overview.personalProjects] as? [String: AnyObject],
              let work = overviewData[Constants.Data.Overview.workProjects] as? [String: AnyObject] else
        {
            print("Error: setOverview - [originDate, statement, personal, work] not found in parameter")
            return
        }
        overview.setValue(originDate, forKeyPath: Constants.Data.Overview.originDate)
        overview.setValue(statement, forKeyPath: Constants.Data.Overview.statement)
        
        let lists = [personal, work]
        let types = [Constants.Data.Overview.personalProjects, Constants.Data.Overview.workProjects]
        for (i, keyList) in [personal.keys, work.keys].enumerated() {
           keyList.forEach { languageKeys in
                guard let languageData = lists[i][languageKeys] as? [String: AnyObject],
                      let language = languageData[Constants.Data.Overview.language] as? String,
                      let days = languageData[Constants.Data.Overview.days] as? String,
                      let color = languageData[Constants.Data.Overview.color] as? String else
                {
                    print("Error: setOverview - [language, days, color] not found in \(types[i]) data")
                    return
                }
                let x = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.OverviewProject, in: managedContext)!
                let newLanguage = NSManagedObject(entity: x, insertInto: managedContext)
                newLanguage.setValue(types[i], forKey: Constants.Data.Overview.type)
                newLanguage.setValue(language, forKey: Constants.Data.Overview.language)
                newLanguage.setValue(days, forKey: Constants.Data.Overview.days)
                newLanguage.setValue(overview, forKey: Constants.Data.Overview.manyToOne)
                newLanguage.setValue(languageKeys, forKey: Constants.Data.Overview.key)
                newLanguage.setValue(color, forKey: Constants.Data.Overview.color)
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
        overview = [:]
        var tempOverview: [String: AnyObject] = [:]
        
        guard let object = objects.first,
              let originDate = object.originDate,
              let statement = object.statement,
              let projects = object.projects?.allObjects as? [OverviewProject] /* Set One-to-Many */ else
        {
            print("Error: loadOverview - [object, originDate, statement, projects] not found in OverviewData")
            return
        }
        
        var personal: [String: AnyObject] = [:]
        var work: [String: AnyObject] = [:]
        projects.forEach { project in
            guard let projectKey = project.key,
                  let projectType = project.type else
            {
                print("Error: loadOverview - [key] not found in OverviewData")
                return
            }
            if projectType == Constants.Data.Overview.personalProjects {
                personal[projectKey] = [Constants.Data.Overview.language: project.language,
                                        Constants.Data.Overview.days: project.days,
                                        Constants.Data.Overview.color: project.color] as AnyObject
            }
            else if projectType == Constants.Data.Overview.workProjects {
                work[projectKey] = [Constants.Data.Overview.language: project.language,
                                    Constants.Data.Overview.days: project.days,
                                    Constants.Data.Overview.color: project.color] as AnyObject
            }
        }
        
        tempOverview[Constants.Data.Overview.originDate] = originDate as AnyObject
        tempOverview[Constants.Data.Overview.statement] = statement as AnyObject
        tempOverview[Constants.Data.Overview.personalProjects] = personal as AnyObject
        tempOverview[Constants.Data.Overview.workProjects] = work as AnyObject
        overview = tempOverview
        self.customDelegate.reloadOverview()
    }
    
    //MARK: CoreData Work
    static func setWork(workData: [String: AnyObject]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        workData.keys.forEach { companyKey in
            let workEntity = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.Work, in: managedContext)!
            let work = NSManagedObject(entity: workEntity, insertInto: managedContext)
            guard let job = workData[companyKey] as? [String: AnyObject],
                  let company = job[Constants.Data.Work.company] as? String,
                  let positions = job[Constants.Data.Work.positions] as? [String: AnyObject] else
            {
                print("Error: setWork - [job, company, positions] not found in parameter")
                return
            }
            work.setValue(company, forKeyPath: Constants.Data.Work.company)
            work.setValue(companyKey, forKeyPath: Constants.Data.Work.key)
            positions.keys.forEach { positionKey in
                guard let position = positions[positionKey],
                      let startDate = position[Constants.Data.Work.startDate] as? String,
                      let title = position[Constants.Data.Work.title] as? String,
                      let workCompleted = position[Constants.Data.Work.workCompleted] as? String else
                {
                    print("Error: setWork - [position, startDate, title, workCompleted] not found in parameter")
                    return
                }
                let x = NSEntityDescription.entity(forEntityName: Constants.Data.CoreData.WorkPosition, in: managedContext)!
                let newPosition = NSManagedObject(entity: x, insertInto: managedContext)
                newPosition.setValue(positionKey, forKeyPath: Constants.Data.Work.key)
                newPosition.setValue(startDate, forKeyPath: Constants.Data.Work.startDate)
                newPosition.setValue(title, forKeyPath: Constants.Data.Work.title)
                newPosition.setValue(workCompleted, forKeyPath: Constants.Data.Work.workCompleted)
                newPosition.setValue(work, forKey: Constants.Data.Work.manyToOne)
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
            guard let companyKey = object.key,
                  let company = object.company,
                  let positions = object.positions?.allObjects as? [WorkPosition] /* Set One-to-Many */ else
            {
                print("Error: loadWork - [companyKey, company, positions] not found in WorkData")
                return
            }
            var positionsList: [String: AnyObject] = [:]
            positions.forEach { object in
                guard let positionKey = object.key,
                      let startDate = object.startDate,
                      let title = object.title,
                      let workCompleted = object.workCompleted else
                {
                    print("Error: loadWork - [positionKey, startDate, title, workCompleted] not found in WorkData")
                    return
                }
                positionsList[positionKey] = [Constants.Data.Work.startDate: startDate,
                                              Constants.Data.Work.title: title,
                                              Constants.Data.Work.workCompleted: workCompleted] as AnyObject
            }
            work[companyKey] = [Constants.Data.Work.company: company,
                                Constants.Data.Work.positions: positionsList] as AnyObject
        }
        self.customDelegate.reloadWork()
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

