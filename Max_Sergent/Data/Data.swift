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
    func resetColorScheme()
    func resetOverview()
    func resetTimeline()
    func resetPieData()
    func resetConcepts()
}

struct Data {
    
    //MARK: Definitions
    // Delegates
    static var customDelegate : DataDelegate!
    // Objects
    static var lastUpdate:                  String = ""
    static var appInfo:                     [String: AnyObject] = [:]
    static var colorScheme:                 [String: AnyObject] = [:]
    static var overview:                    [String: String] = [:]
    static var overviewTable:               [(title: String, boxes: [(icon: String, content: String)])] = []
    static var timeline:                    [String: AnyObject] = [:]
    static var timelineTable:               [[String: Any]] = []
    static var pieOriginDate:               String = ""
    static var pie:                         [[String: Any]] = []
    static var concepts:                    [[String: Any]] = []
    static var conceptIconsSavedInMemory:   [String] = []
    
    // MARK: Clear Testing
    static func clearAllDataForTesting(){
        // Delete core data entities
        deleteCoreData(forEntity: Constants.CoreData_Entity.appInfo)
        deleteCoreData(forEntity: Constants.CoreData_Entity.colorScheme)
        deleteCoreData(forEntity: Constants.CoreData_Entity.overview)
        deleteCoreData(forEntity: Constants.CoreData_Entity.timeline)
        deleteCoreData(forEntity: Constants.CoreData_Entity.pie)
        deleteCoreData(forEntity: Constants.CoreData_Entity.concepts)
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
            loadColorScheme()
            loadOverview()
            loadTimeline()
            loadPieData()
            loadConcepts()
            lastUpdate = UserDefaults.standard.string(forKey: Constants.UserDefaults.lastUpdate)!
            ViewController.lastUpdate.text = "last updated:\n\(lastUpdate)"
        }
        else {
            print("Load from Firebase")
            firebaseAll {
                //UserDefaults.standard.set(true, forKey: Constants.UserDefaults.coreData)
                let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .none)
                UserDefaults.standard.set(timestamp, forKey: Constants.UserDefaults.lastUpdate)
                lastUpdate = UserDefaults.standard.string(forKey: Constants.UserDefaults.lastUpdate)!
                ViewController.lastUpdate.text = "last updated:\n\(lastUpdate)"
            }
        }
    }
    
    //MARK: Firebase All
    static func firebaseAll(completion:@escaping () -> Void) {
        firebaseAppInfo()
        firebaseColorScheme()
        firebaseOverview()
        firebaseTimeline()
        firebasePieData()
        firebaseConcepts()
        completion()
    }

    //MARK: UserDefaults
    static func coreDataPopulated() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.UserDefaults.coreData)
    }
    
}
