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
    
    static let experience: [String : [(position: String, work: String)]] =
        ["BEA":
            [(position: "Analyst", work: "I was lucky — I found what I loved to do early in life. Woz and I started Apple in my parents’ garage when I was 20. We worked hard, and in 10 years Apple had grown from just the two of us in a garage into a $2 billion company with over 4,000 employees."),
             (position: "Economist", work: "We had just released our finest creation — the Macintosh — a year earlier, and I had just turned 30. And then I got fired. How can you get fired from a company you started? Well, as Apple grew we hired someone who I thought was very talented to run the company with me, and for the first year or so things went well. ")],
        "Toggle":
            [(position: "Co-Founder", work: "But then our visions of the future began to diverge and eventually we had a falling out. When we did, our Board of Directors sided with him. So at 30 I was out. And very publicly out. What had been the focus of my entire adult life was gone, and it was devastating.")]
        ]
     
//    static func imageStuff() {
//        if let success = UIImage(named: "placeholder.png")?.saveImage(as: "placeholder") {
//
//        }
//        if let image = loadImage(named: "placeholder") {
//            print("loaded")
//            print(image)
//        }
//    }
//
//    static func loadImage(named: String) -> UIImage? {
//        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
//        }
//        return nil
//    }
//
//    static func deleteImages() {
//        let fileManager = FileManager.default
//        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        do {
//            try fileManager.removeItem(at: myDocuments)
//        } catch {
//            return
//        }
//    }
//
//    static func contentsOfDocumentsDirectory() {
//        do {
//            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let docs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [], options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
//            print(docs)
//        } catch {
//            print(error)
//        }
//    }
    
    static func reloadFirebase(for key: String) {
        firebaseReset() { reset in
            if reset {
                firebaseProfile()
                firebaseOverview()
                firebaseWork()
            }
            else {
                print("Do not reset from Firebase")
            }
        }
    }
    
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
    
    static func firebaseProfile() {
        Database.database().reference(withPath: Constants.Data.Firebase.profile).observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if  let name = dict[Constants.Data.Profile.name] as? String,
                    let pictureURL = dict[Constants.Data.Profile.picture] as? String
                {
                    //print("-- PROFILE ------")
                    //print(name," | ",pictureURL)
                }
            }
        })
    }
    
    static func firebaseOverview() {
        Database.database().reference(withPath: Constants.Data.Firebase.overview).observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String: AnyObject] {
                if  let originDate = dict[Constants.Data.Overview.originDate] as? String,
                    let personalProjects = dict[Constants.Data.Overview.personalProjects] as? [String: AnyObject],
                    let workProjects = dict[Constants.Data.Overview.workProjects] as? [String: AnyObject],
                    let statement = dict[Constants.Data.Overview.statement]
                {
                    //print("-- OVERVIEW ------")
                    //print(originDate,"\n",statement)
                    personalProjects.keys.forEach { key in
                        if let dict = personalProjects[key] as? [String: AnyObject] {
                            if  let language = dict[Constants.Data.Overview.language] as? String,
                                let days = dict[Constants.Data.Overview.days] as? Int
                            {
                                //print("\(language) | \(days)")
                            }
                        }
                    }
                    workProjects.keys.forEach { key in
                        if let dict = workProjects[key] as? [String: AnyObject] {
                            if  let language = dict[Constants.Data.Overview.language] as? String,
                                let days = dict[Constants.Data.Overview.days] as? Int
                            {
                                //print("\(language) | \(days)")
                            }
                        }
                    }
                }
            }
        })
    }
    
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
