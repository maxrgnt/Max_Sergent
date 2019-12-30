//
//  Data_Firebase.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/30/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

extension Data {
    
    //MARK: Firebase All
    static func firebaseAll(completion:@escaping () -> Void) {
        //print("startFireBaseAll")
        firebaseProfile()
        firebaseOverview()
        firebaseWork()
        completion()
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
            if let workData = snapshot.value as? [String: AnyObject] {
                workData.keys.forEach { jobKey in
                    if  let job = workData[jobKey] as? [String: AnyObject],
                        let company = job[Constants.Data.Work.company] as? String,
                        let positions = job[Constants.Data.Work.positions] as? [String: AnyObject]
                    {
                        var positionsList: [String: AnyObject] = [:]
                        positions.keys.forEach { positionKey in
                            if  let position = positions[positionKey],
                                let startDate = position[Constants.Data.Work.startDate] as? String,
                                let title = position[Constants.Data.Work.title] as? String,
                                let workCompleted = position[Constants.Data.Work.workCompleted] as? String
                            {
                                positionsList[positionKey] = [Constants.Data.Work.startDate: startDate,
                                                              Constants.Data.Work.title: title,
                                                              Constants.Data.Work.workCompleted: workCompleted] as AnyObject
                            }
                            else {
                                print("ERROR: Could not access dictionary using positionKey in firebaseWork")
                            }
                        }
                        work[jobKey] = [Constants.Data.Work.company: company,
                                         Constants.Data.Work.positions: positionsList] as AnyObject
                    }
                    else {
                        print("ERROR: Could not access dictionary using jobKey in firebaseWork")
                    }
                }
                coreDataPopulated() ? deleteCoreData(forEntity: Constants.Data.CoreData.Work) : nil
                setWork(workData: work)
            }
            else {
                print("ERROR: Could not access workData snapshot in firebaseWork")
            }
        })
    }

    
}
