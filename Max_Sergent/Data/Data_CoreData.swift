//
//  Data_CoreData.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension Data {
        
    //MARK: CoreData Delete
    static func deleteCoreData(forEntity entity: String) {
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
    
    //MARK: AppInfo
    static func setAppInfo(userName: String, watermark: String, photo: UIImage) {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.appInfo, in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        // Entity specific here
        object.setValue(userName,   forKeyPath: Constants.Data_Key.userName)
        object.setValue(watermark,  forKeyPath: Constants.Data_Key.watermark)
        do {
            try managedContext.save()
            if photo.saveImage(as: Constants.Data_Key.appInfoPhoto) {
                do {
                    let documentsURL = try
                        FileManager.default.url(for: .documentDirectory,
                                                in: .userDomainMask,
                                                appropriateFor: nil,
                                                create: false)
                    let docs = try
                        FileManager.default.contentsOfDirectory(at: documentsURL,
                                                                includingPropertiesForKeys: [],
                                                                options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
//                    print(docs)
                    loadAppInfo()
                } catch {
                    print(error)
                }
            }
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadAppInfo() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.appInfo)
        let fetch  = try! managedContext.fetch(entity) as! [AppInfo]
        // Entity specific here
        guard   let object    = fetch.first,
                let userName  = object.userName,
                let watermark = object.watermark else
        {
            print("Error: loadProfile - coreData not found")
            return
        }

        guard let dir = try?
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else
        {
            return
        }

        let urlFromCoreData = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(Constants.Data_Key.appInfoPhoto)
        let photo = UIImage(contentsOfFile: urlFromCoreData.path) ?? UIImage(named: Constants.Placeholder.photoURL)

        appInfo = [Constants.Data_Key.watermark:    watermark as AnyObject,
                   Constants.Data_Key.userName:     userName  as AnyObject,
                   Constants.Data_Key.appInfoPhoto: photo!]
        
        appInfoLoaded = true
    }
    
    //MARK: Color Scheme
    static func setColorScheme() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.colorScheme, in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        // Entity specific here
        object.setValue(colorScheme[Constants.Data_Key.education],         forKeyPath: Constants.Data_Key.education)
        object.setValue(colorScheme[Constants.Data_Key.experience],         forKeyPath: Constants.Data_Key.experience)
        object.setValue(colorScheme[Constants.Data_Key.project],        forKeyPath: Constants.Data_Key.project)
        object.setValue(colorScheme[Constants.Data_Key.background1], forKeyPath: Constants.Data_Key.background1)
        object.setValue(colorScheme[Constants.Data_Key.background2], forKeyPath: Constants.Data_Key.background2)
        object.setValue(colorScheme[Constants.Data_Key.background3], forKeyPath: Constants.Data_Key.background3)
        object.setValue(colorScheme[Constants.Data_Key.font1],       forKeyPath: Constants.Data_Key.font1)
        object.setValue(colorScheme[Constants.Data_Key.font2],       forKeyPath: Constants.Data_Key.font2)
        object.setValue(colorScheme[Constants.Data_Key.effectStyle], forKeyPath: Constants.Data_Key.effectStyle)
        do {
            try managedContext.save()
            loadColorScheme()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadColorScheme() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.colorScheme)
        let fetch  = try! managedContext.fetch(entity) as! [ColorScheme]
        // Entity specific here
        guard let object      = fetch.first,
              let edu         = object.timeline_education,
              let exp         = object.timeline_experience,
              let proj        = object.timeline_project,
              let background1 = object.background1,
              let background2 = object.background2,
              let background3 = object.background3,
              let font1       = object.font1,
              let font2       = object.font2,
              let effectStyle = object.effectStyle else
        {
            print("Error: loadOverview - coreData not found")
            return
        }
        colorScheme = [Constants.Data_Key.experience:  exp,
                       Constants.Data_Key.education:   edu,
                       Constants.Data_Key.project:     proj,
                       Constants.Data_Key.background1: background1,
                       Constants.Data_Key.background2: background2,
                       Constants.Data_Key.background3: background3,
                       Constants.Data_Key.font1:       font1,
                       Constants.Data_Key.font2:       font2,
                       Constants.Data_Key.effectStyle: effectStyle]
        
        colorSchemeLoaded = true
    }
    
    //MARK: Overview
    static func setOverview(email: String,           email_subject: String,    email_body: String,
                            linkedinAppURL: String,  linkedinWebURL: String,
                            locationBackEnd: String, locationFrontEnd: String,
                            objective: String)
    {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.overview, in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        // Entity specific here
        object.setValue(email,            forKeyPath: Constants.Data_Key.email)
        object.setValue(email_subject,    forKeyPath: Constants.Data_Key.email_subject)
        object.setValue(email_body,       forKeyPath: Constants.Data_Key.email_body)
        object.setValue(linkedinAppURL,   forKeyPath: Constants.Data_Key.linkedinAppURL)
        object.setValue(linkedinWebURL,   forKeyPath: Constants.Data_Key.linkedinWebURL)
        object.setValue(locationBackEnd,  forKeyPath: Constants.Data_Key.locationBackEnd)
        object.setValue(locationFrontEnd, forKeyPath: Constants.Data_Key.locationFrontEnd)
        object.setValue(objective,        forKeyPath: Constants.Data_Key.objective)
        do {
            try managedContext.save()
            loadOverview()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadOverview() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.overview)
        let fetch  = try! managedContext.fetch(entity) as! [Overview]
        // Entity specific here
        guard   let object           = fetch.first,
                let email            = object.email,
                let email_subject    = object.email_subject,
                let email_body       = object.email_body,
                let linkedinAppURL   = object.linkedinAppURL,
                let linkedinWebURL   = object.linkedinWebURL,
                let locationBackEnd  = object.locationBackEnd,
                let locationFrontEnd = object.locationFrontEnd,
                let objective        = object.objective else
        {
            print("Error: loadOverview - coreData not found")
            return
        }
        overview = [Constants.Data_Key.email:            email,
                    Constants.Data_Key.email_subject:    email_subject,
                    Constants.Data_Key.email_body:       email_body,
                    Constants.Data_Key.linkedinAppURL:   linkedinAppURL,
                    Constants.Data_Key.linkedinWebURL:   linkedinWebURL,
                    Constants.Data_Key.locationBackEnd:  locationBackEnd,
                    Constants.Data_Key.locationFrontEnd: locationFrontEnd,
                    Constants.Data_Key.objective:        objective]
        overviewLoaded = true
    }
    
    //MARK: Timeline
    static func setTimeline() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        timeline.keys.forEach { key in
            // Starts to differ here
            let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.timeline, in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            // Entity specific here
            object.setValue(timeline[key]![Constants.Data_Key.organization]!, forKeyPath: Constants.Data_Key.organization)
            object.setValue(timeline[key]![Constants.Data_Key.year]!,         forKeyPath: Constants.Data_Key.year)
            object.setValue(timeline[key]![Constants.Data_Key.index]!,        forKeyPath: Constants.Data_Key.index)
            object.setValue(timeline[key]![Constants.Data_Key.details]!,      forKeyPath: Constants.Data_Key.details)
            object.setValue(timeline[key]![Constants.Data_Key.iconName]!,     forKeyPath: Constants.Data_Key.iconName)
            object.setValue(timeline[key]![Constants.Data_Key.type]!,         forKeyPath: Constants.Data_Key.type)
            object.setValue(key,                                              forKeyPath: Constants.Data_Key.key)
        }
        do {
            try managedContext.save()
            loadTimeline()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadTimeline() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.timeline)
        let fetch  = try! managedContext.fetch(entity) as! [Timeline]
        // Entity specific here
        timeline = [:]
        fetch.forEach { object in
            guard   let organization = object.organization,
                    let details      = object.details,
                    let iconName     = object.iconName,
                    let type         = object.type,
                    let key          = object.key else
            {
                print("Error: loadTimeline - coreData not found")
                return
            }
            timeline[key] = [Constants.Data_Key.organization: organization,
                             Constants.Data_Key.year:         object.year,
                             Constants.Data_Key.index:        object.index,
                             Constants.Data_Key.details:      details,
                             Constants.Data_Key.iconName:     iconName,
                             Constants.Data_Key.type:         type] as AnyObject
        }
        timelineLoaded = true
    }
    
    //MARK: Future
    static func setFuture() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        future.forEach { iconName in
            // Starts to differ here
            let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.future, in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            // Entity specific here
            object.setValue(iconName, forKeyPath: Constants.Data_Key.iconName)
        }
        do {
            try managedContext.save()
            UserDefaults.standard.set(futureYear, forKey: Constants.UserDefaults.futureYear)
            loadFuture()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadFuture() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.future)
        let fetch  = try! managedContext.fetch(entity) as! [Future]
        // Entity specific here
        future = []
        fetch.forEach { object in
            guard let iconName = object.iconName else
            {
                print("Error: loadTimeline - coreData not found")
                return
            }
            future.append(iconName)
        }
        futureYear = UserDefaults.standard.string(forKey: Constants.UserDefaults.futureYear)!
        futureLoaded = true
    }
    
    //MARK: Pie
    static func setPieData() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        pie.forEach { piece in
            // Starts to differ here
            let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.pie, in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            // Entity specific here
            object.setValue(piece[Constants.Data_Key.color]!, forKeyPath: Constants.Data_Key.color)
            object.setValue(piece[Constants.Data_Key.piece]!, forKeyPath: Constants.Data_Key.piece)
            object.setValue(piece[Constants.Data_Key.index]!, forKeyPath: Constants.Data_Key.index)
            object.setValue(piece[Constants.Data_Key.days]!,  forKeyPath: Constants.Data_Key.days)
        }
        do {
            try managedContext.save()
            UserDefaults.standard.set(pieOriginDate, forKey: Constants.UserDefaults.pieOriginDate)
            loadPieData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadPieData() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.pie)
        let fetch  = try! managedContext.fetch(entity) as! [PieData]
        // Entity specific here
        pie = []
        fetch.forEach { object in
            guard   let color = object.color,
                    let piece = object.piece else
            {
                print("Error: loadPieData - coreData not found")
                return
            }
            pie.append([Constants.Data_Key.color: color,
                        Constants.Data_Key.piece: piece,
                        Constants.Data_Key.index: object.index,
                        Constants.Data_Key.days:  object.days])
        }
        pieOriginDate = UserDefaults.standard.string(forKey: Constants.UserDefaults.pieOriginDate)!
        pieLoaded = true
    }
    
    //MARK: Concepts
    static func setConcepts() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        concepts.forEach { piece in
            // Starts to differ here
            let entity = NSEntityDescription.entity(forEntityName: Constants.CoreData_Entity.concepts, in: managedContext)!
            let object = NSManagedObject(entity: entity, insertInto: managedContext)
            // Entity specific here
            object.setValue(piece[Constants.Data_Key.title]!,    forKeyPath: Constants.Data_Key.title)
            object.setValue(piece[Constants.Data_Key.iconName]!, forKeyPath: Constants.Data_Key.iconName)
        }
        do {
            try managedContext.save()
            loadConcepts()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func loadConcepts() {
        // Boiler-plate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        // Starts to differ here
        let entity = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.CoreData_Entity.concepts)
        let fetch  = try! managedContext.fetch(entity) as! [ConceptData]
        // Entity specific here
        concepts = []
        fetch.forEach { object in
            guard   let title    = object.title,
                    let iconName = object.iconName else
            {
                print("Error: loadConcepts - coreData not found")
                return
            }
            concepts.append([Constants.Data_Key.title:    title,
                             Constants.Data_Key.iconName: iconName])
        }
        conceptsLoaded = true
    }
    
}
