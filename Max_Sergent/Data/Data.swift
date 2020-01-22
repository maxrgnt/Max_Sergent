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
    func reloadingFirebase()
    func checkIfAllDataLoaded()
}

struct Data {
    
    static var customDelegate: DataDelegate!
    
    //MARK: Definitions
    // Delegates
    // Objects
    static var lastUpdate:                  String = ""
    static var appInfo:                     [String: AnyObject] = [:]
    static var colorScheme:                 [String: String] = [:]
    static var overview:                    [String: String] = [:]
    static var overviewTable:               [(title: String, boxes: [(icon: String, content: String)])] = []
    static var timeline:                    [String: AnyObject] = [:]
    static var timelineTable:               [[String: Any]] = []
    static var timelineIconsSavedInMemory:  [String] = []
    static var timelineb:                   [String] = []
    static var timelinebIconsSavedInMemory: [String] = []
    static var pieOriginDate:               String = ""
    static var pie:                         [[String: Any]] = []
    static var concepts:                    [[String: Any]] = []
    static var conceptIconsSavedInMemory:   [String] = []
    
    //MARK: Data Load Tracking
    static var colorSchemeLoaded = false
    static var appInfoLoaded     = false
    static var overviewLoaded    = false
    static var timelineLoaded    = false
    static var timelinebLoaded   = false
    static var pieLoaded         = false
    static var conceptsLoaded    = false
    static var allDataLoaded     = false
    
    static func dataLoadTracker() {
        print("tracking..")
        var overall = false
        for check in [colorSchemeLoaded,appInfoLoaded,overviewLoaded,timelineLoaded,timelinebLoaded,pieLoaded,conceptsLoaded] {
            overall = check
            if !check {
                break
            }
        }
        print([colorSchemeLoaded,appInfoLoaded,overviewLoaded,timelineLoaded,timelinebLoaded,pieLoaded,conceptsLoaded])
        if !overall {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                dataLoadTracker()
            }
        }
        else {
            print("DONE!")
            allDataLoaded = true
            print(Date())
        }
    }
    
    //MARK: Clear Testing
    static func clearAllDataForTesting(){
        // Delete core data entities
        deleteCoreData(forEntity: Constants.CoreData_Entity.appInfo)
        deleteCoreData(forEntity: Constants.CoreData_Entity.colorScheme)
        deleteCoreData(forEntity: Constants.CoreData_Entity.overview)
        deleteCoreData(forEntity: Constants.CoreData_Entity.timeline)
        deleteCoreData(forEntity: Constants.CoreData_Entity.timelineb)
        deleteCoreData(forEntity: Constants.CoreData_Entity.pie)
        deleteCoreData(forEntity: Constants.CoreData_Entity.concepts)
        // Delete onboarding/keyboard/userAgreement user default data
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        // Delete saved images
        deleteImages()
    }
    
    static func deleteImages() {
        let fileManager = FileManager.default
        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            try fileManager.removeItem(at: myDocuments)
        } catch {
            return
        }
    }

    func contentsOfDocumentsDirectory() {
        do {
            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let docs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [], options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
            print(docs)
        } catch {
            print(error)
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
        let backgroundQueue = DispatchQueue(label: "com.app.queue", qos: .background)
        backgroundQueue.async {
             print("Run on background thread")
             dataLoadTracker()
        }
        if !reset && coreDataPopulated() {
            print("Load from CoreData")
            self.customDelegate.checkIfAllDataLoaded()
            loadAppInfo()
            loadColorScheme()
            loadOverview()
            loadTimeline()
            loadTimelineb()
            loadPieData()
            loadConcepts()
            lastUpdate = UserDefaults.standard.string(forKey: Constants.UserDefaults.lastUpdate)!
            ViewController.lastUpdate.text = "last updated:\n\(lastUpdate)"
        }
        else {
            print("Load from Firebase")
            colorSchemeLoaded = false
            appInfoLoaded     = false
            overviewLoaded    = false
            timelineLoaded    = false
            pieLoaded         = false
            conceptsLoaded    = false
            allDataLoaded     = false
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                self.customDelegate.reloadingFirebase()
            }
            firebaseAll {
                UserDefaults.standard.set(true, forKey: Constants.UserDefaults.coreData)
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
        firebaseTimelineB()
        firebasePieData()
        firebaseConcepts()
        completion()
    }

    //MARK: UserDefaults
    static func coreDataPopulated() -> Bool {
        return UserDefaults.standard.bool(forKey: Constants.UserDefaults.coreData)
    }
    
}
