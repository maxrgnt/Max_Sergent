//
//  Data_Firebase.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

extension Data {
    
    //MARK: Firebase Reset
    static func firebaseReset(completionHandler:@escaping (Bool) -> ()) {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.reset)
        ref.observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: AnyObject] else {
                completionHandler(false)
                print("Error: firebaseReset - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard let reset = value[Constants.Data_Key.proceed] as? Bool else {
                completionHandler(false)
                print("Error: firebaseReset - [proceed] not convertible")
                return
            }
            completionHandler(reset)
        })
    }
    
    //MARK: Firebase ColorScheme
    static func firebaseColorScheme() {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.colorScheme)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseColorScheme - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard   let exp         = value[Constants.Data_Key.exp]         as? String,
                    let edu         = value[Constants.Data_Key.edu]         as? String,
                    let proj        = value[Constants.Data_Key.proj]        as? String,
                    let background1 = value[Constants.Data_Key.background1] as? String,
                    let background2 = value[Constants.Data_Key.background2] as? String,
                    let background3 = value[Constants.Data_Key.background3] as? String,
                    let font        = value[Constants.Data_Key.font]        as? String,
                    let effectStyle = value[Constants.Data_Key.effectStyle] as? String else
            {
                print("Error: firebaseColorScheme - value objects not convertible")
                return
            }
            colorScheme = [Constants.Data_Key.exp:         exp,
                           Constants.Data_Key.edu:         edu,
                           Constants.Data_Key.proj:        proj,
                           Constants.Data_Key.background1: background1,
                           Constants.Data_Key.background2: background2,
                           Constants.Data_Key.background3: background3,
                           Constants.Data_Key.font:        font,
                           Constants.Data_Key.effectStyle: effectStyle]
            // If CoreData has been populated already, first delete what is saved before saving new data
            deleteCoreData(forEntity: Constants.CoreData_Entity.colorScheme)
            setColorScheme()
        })
    }
    
    //MARK: Firebase AppInfo
    static func firebaseAppInfo() {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.appInfo)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseAppInfo - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard   let userName  = value[Constants.Data_Key.userName]        as? String,
                    let watermark = value[Constants.Data_Key.watermark]       as? String,
                    let photoURL  = value[Constants.Data_Key.appInfoPhotoURL] as? String else
            {
                print("Error: firebaseAppInfo - value objects not convertible")
                return
            }
            // If CoreData has been populated already, first delete what is saved before saving new data
            deleteCoreData(forEntity: Constants.CoreData_Entity.appInfo)
            print(photoURL)
            let storageRef = Storage.storage().reference(forURL: photoURL)
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    print(error)
                    setAppInfo(userName:  userName,
                               watermark: watermark,
                               photo:     UIImage(named: Constants.Placeholder.photoURL)!)
                }
                else {
                    setAppInfo(userName:  userName,
                               watermark: watermark,
                               photo:     UIImage(data: data!)!)
                }
            }
        })
    }
    
    //MARK: Firebase Overview
    static func firebaseOverview() {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.overview)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseOverview - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard   let email            = value[Constants.Data_Key.email]            as? String,
                    let email_subject    = value[Constants.Data_Key.email_subject]    as? String,
                    let email_body       = value[Constants.Data_Key.email_body]       as? String,
                    let linkedinAppURL   = value[Constants.Data_Key.linkedinAppURL]   as? String,
                    let linkedinWebURL   = value[Constants.Data_Key.linkedinWebURL]   as? String,
                    let locationBackEnd  = value[Constants.Data_Key.locationBackEnd]  as? String,
                    let locationFrontEnd = value[Constants.Data_Key.locationFrontEnd] as? String,
                    let objective        = value[Constants.Data_Key.objective]        as? String else
            {
                print("Error: firebaseOverview - value objects not convertible")
                return
            }
            // If CoreData has been populated already, first delete what is saved before saving new data
            deleteCoreData(forEntity: Constants.CoreData_Entity.overview)
            setOverview(email: email,                     email_subject: email_subject,   email_body: email_body,
                        linkedinAppURL: linkedinAppURL,   linkedinWebURL: linkedinWebURL,
                        locationBackEnd: locationBackEnd, locationFrontEnd: locationFrontEnd,
                        objective: objective)
        })
    }
    
    //MARK: Firebase Timeline
    static func firebaseTimeline() {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.timeline)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let values = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseTimeline - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            timeline = [:]
            values.keys.forEach { key in
                guard   let organization = values[key]![Constants.Data_Key.organization] as? String,
                        let year         = values[key]![Constants.Data_Key.year]         as? Int,
                        let details      = values[key]![Constants.Data_Key.details]      as? String,
                        let index        = values[key]![Constants.Data_Key.index]        as? Int,
                        let iconName     = values[key]![Constants.Data_Key.iconName]     as? String,
                        let type         = values[key]![Constants.Data_Key.type]         as? String else
                {
                    print("Error: firebaseTimeline - value objects not convertible")
                    return
                }
                timeline[key] = [Constants.Data_Key.organization: organization,
                                 Constants.Data_Key.year:         year,
                                 Constants.Data_Key.index:        index,
                                 Constants.Data_Key.details:      details,
                                 Constants.Data_Key.iconName:     iconName,
                                 Constants.Data_Key.type:         type] as AnyObject
            }
            
            // If CoreData has been populated already, first delete what is saved before saving new data
            deleteCoreData(forEntity: Constants.CoreData_Entity.timeline)
            setTimeline()
        })
    }
    
    //MARK: Firebase Pie
    static func firebasePieData() {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.pie)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let values = snapshot.value as? [String: AnyObject] else {
                print("Error: firebasePie - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard let originDate = values[Constants.Data_Key.originDate] as? String else
            {
                print("Error: firebasePie - value objects (1) not convertible")
                return
            }
            pie = []
            let keys = values.keys.sorted().dropFirst()
            keys.forEach { key in
                guard   let color = values[key]![Constants.Data_Key.color] as? String,
                        let piece = values[key]![Constants.Data_Key.piece] as? String,
                        let days  = values[key]![Constants.Data_Key.days]  as? Int,
                        let index = values[key]![Constants.Data_Key.index] as? Int else
                {
                    print("Error: firebasePie - value objects (2) not convertible")
                    return
                }
                pie.append([Constants.Data_Key.color: color,
                            Constants.Data_Key.piece: piece,
                            Constants.Data_Key.days:  days,
                            Constants.Data_Key.index: index])
            }
            pieOriginDate = originDate
            // If CoreData has been populated already, first delete what is saved before saving new data
            deleteCoreData(forEntity: Constants.CoreData_Entity.pie)
            setPieData()
        })
    }
    
    //MARK: Firebase Concepts
    static func firebaseConcepts() {
        let ref = Database.database().reference(withPath: Constants.Firebase_Path.concepts)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            guard let values = snapshot.value as? [String: AnyObject] else {
                print("Error: firebasePie - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            concepts = []
            conceptIconsSavedInMemory = []
            let keys = values.keys.sorted()
            keys.forEach { key in
                guard   let title    = values[key]![Constants.Data_Key.title]    as? String,
                        let iconName = values[key]![Constants.Data_Key.iconName] as? String,
                        let iconURL  = values[key]![Constants.Data_Key.iconURL]  as? String else
                {
                    print("Error: firebaseConcepts - value objects not convertible")
                    return
                }
                concepts.append([Constants.Data_Key.title:    title,
                                 Constants.Data_Key.iconName: Constants.Image_Prefix.concept+iconName])
                let storageRef = Storage.storage().reference(forURL: iconURL)
                storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print(error)
                    }
                    else {
                        if UIImage(data: data!)!.saveImage(as: Constants.Image_Prefix.concept+iconName) {
                            if key == keys.last! {
                                firebaseCheckForConceptIcons()
                            }
                        }
                        else {

                        }
                    }
                }
            }
        })
    }
    
    static func firebaseCheckForConceptIcons() {
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false)
            let docs = try FileManager.default.contentsOfDirectory(at: documentsURL,
                                                                   includingPropertiesForKeys: [],
                                                                   options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            if conceptIconsSavedInMemory.count < concepts.count {
                docs.forEach { doc in
                    let docString = String(describing: doc)
                    let splitFileName = docString.split(separator:"/")
                    let imageName = String(describing: splitFileName.last!)
                    if imageName.hasPrefix(Constants.Image_Prefix.concept) { //&& !conceptIconsSavedInMemory.contains(imageName) {
                        conceptIconsSavedInMemory.append(imageName)
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    firebaseCheckForConceptIcons()
                }
            }
            else {
                //print(conceptIconsSavedInMemory)
                // If CoreData has been populated already, first delete what is saved before saving new data
                deleteCoreData(forEntity: Constants.CoreData_Entity.concepts)
                setConcepts()
            }
        } catch {
            print(error)
        }
    }
    
}
