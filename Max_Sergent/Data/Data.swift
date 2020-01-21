//
//  Data.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import FirebaseStorage

protocol DataDelegate {
    func resetAppInfo()
    func resetOverview()
    func resetTimeline()
    func resetPieData()
}

struct Data {
    
    //MARK: Definitions
    // Delegates
    static var customDelegate : DataDelegate!
    // Objects
    static var appInfo:         [String: AnyObject] = [:]
    static var overview:        [String: String] = [:]
    static var overviewTable:   [(title: String, boxes: [(icon: String, content: String)])] = []
    static var timeline:        [String: AnyObject] = [:]
    static var timelineTable:   [[String: Any]] = []
    static var pieOriginDate:   String = ""
    static var pie:             [[String: Any]] = []
    
    // MARK: Clear Testing
    static func clearAllDataForTesting(){
        // Delete core data entities
        deleteCoreData(forEntity: Constants.CoreData_Entity.appInfo)
        deleteCoreData(forEntity: Constants.CoreData_Entity.overview)
        deleteCoreData(forEntity: Constants.CoreData_Entity.timeline)
        deleteCoreData(forEntity: Constants.CoreData_Entity.pie)
        // Delete onboarding/keyboard/userAgreement user default data
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        // Delete saved images
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try fileManager.removeItem(at: myDocuments)
        } catch {
            return
        }
    }
    
    //MARK: Populate Data
    static func checkFirebaseForReset() {
        firebaseReset() { reset in
            (reset == true) ? UserDefaults.standard.set(false, forKey: Constants.UserDefaults.coreData) : nil
            print("Reset from Firebase? ",reset)
            populateData(from: reset)
        }
    }

    static func populateData(from reset: Bool) {
        if !reset && coreDataPopulated() {
            print("Load from CoreData")
            loadAppInfo()
            loadOverview()
            loadTimeline()
            loadPieData()
        }
        else {
            print("Load from Firebase")
            firebaseAll {
                //UserDefaults.standard.set(true, forKey: Constants.UserDefaults.coreData)
            }
        }
    }
    
    //MARK: Firebase All
    static func firebaseAll(completion:@escaping () -> Void) {
        firebaseAppInfo()
        firebaseOverview()
        firebaseTimeline()
        firebasePieData()
        completion()
    }

    //MARK: UserDefaults
    static func coreDataPopulated() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.UserDefaults.coreData)
    }
    
}
