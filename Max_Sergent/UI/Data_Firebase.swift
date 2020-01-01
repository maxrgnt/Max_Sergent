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
            guard let dict = snapshot.value as? [String: AnyObject] else {
                completionHandler(false)
                print("Error: firebaseReset - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard let reset = dict[Constants.Data.Reset.proceed] as? Bool else {
                completionHandler(false)
                print("Error: firebaseReset - [proceed] not convertible")
                return
            }
            completionHandler(reset)
        })
    }
    
    //MARK: Firebase Profile
    static func firebaseProfile() {
        //print("Firebase Profile has fired")
        Database.database().reference(withPath: Constants.Data.Firebase.profile).observeSingleEvent(of: .value, with: { snapshot in
            guard let dict = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseProfile - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard let name = dict[Constants.Data.Profile.name] as? String,
                  let pictureURL = dict[Constants.Data.Profile.picture] as? String else
            {
                print("Error: firebaseProfile - [name,pictureURL] not convertible")
                return
            }
            coreDataPopulated() ? deleteCoreData(forEntity: Constants.Data.CoreData.Profile) : nil
            setProfile(name: name, picture: pictureURL)
        })
    }
    
    //MARK: Firebase Overview
    static func firebaseOverview() {
        Database.database().reference(withPath: Constants.Data.Firebase.overview).observeSingleEvent(of: .value, with: { snapshot in
            guard let dict = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseOverview - snapshot.value not convertible to [String: AnyObject]")
                return
            }
            guard let originDate = dict[Constants.Data.Overview.originDate] as? String,
                  let personalProjects = dict[Constants.Data.Overview.personalProjects] as? [String: AnyObject],
                  let workProjects = dict[Constants.Data.Overview.workProjects] as? [String: AnyObject],
                  let statement = dict[Constants.Data.Overview.statement] as? String else
            {
                print("Error: firebaseOverview - [originDate,personalProjects,workProjects,statement] not convertible")
                return
            }
            coreDataPopulated() ? deleteCoreData(forEntity: Constants.Data.CoreData.Overview) : nil
            coreDataPopulated() ? deleteCoreData(forEntity: Constants.Data.CoreData.OverviewProject) : nil
            
            var tempOverview: [String: AnyObject] = [:]
            tempOverview[Constants.Data.Overview.originDate] = originDate as AnyObject
            tempOverview[Constants.Data.Overview.statement] = statement as AnyObject
            tempOverview[Constants.Data.Overview.personalProjects] = personalProjects as AnyObject
            tempOverview[Constants.Data.Overview.workProjects] = workProjects as AnyObject
            setOverview(overviewData: tempOverview)
        })
    }
    
    //MARK: Firebase Work
    static func firebaseWork() {
        Database.database().reference(withPath: Constants.Data.Firebase.work).observeSingleEvent(of: .value, with: { snapshot in
            guard let workData = snapshot.value as? [String: AnyObject] else {
                print("Error: firebaseWork - snapshot.value not convertible to [String: AnyObject]")
                return
            }
                 
            var tempWork: [String: AnyObject] = [:]
            var positionsList: [String: AnyObject] = [:]
            
            workData.keys.forEach { jobKey in
                positionsList = [:]
                guard let job = workData[jobKey] as? [String: AnyObject],
                      let company = job[Constants.Data.Work.company] as? String,
                      let positions = job[Constants.Data.Work.positions] as? [String: AnyObject] else
                {
                    print("Error: firebaseWork - [job, company, positions] not convertible")
                    return
                }
                positions.keys.forEach { positionKey in
                    guard let position = positions[positionKey],
                          let startDate = position[Constants.Data.Work.startDate] as? String,
                          let title = position[Constants.Data.Work.title] as? String,
                          let workCompleted = position[Constants.Data.Work.workCompleted] as? String else
                    {
                        print("Error: firebaseWork - [position, startDate, title, workCompleted] not convertible")
                        return
                    }
                    positionsList[positionKey] = [Constants.Data.Work.startDate: startDate,
                                                  Constants.Data.Work.title: title,
                                                  Constants.Data.Work.workCompleted: workCompleted] as AnyObject
                }
                tempWork[jobKey] = [Constants.Data.Work.company: company,
                                    Constants.Data.Work.positions: positionsList] as AnyObject
            }
            coreDataPopulated() ? deleteCoreData(forEntity: Constants.Data.CoreData.Work) : nil
            setWork(workData: tempWork)
        })
    }
}
