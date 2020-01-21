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
    
}
