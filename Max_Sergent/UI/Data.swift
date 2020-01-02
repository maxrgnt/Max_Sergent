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
    
    static var profile: (name: String, picture: UIImage)!
    static var overview: [String: AnyObject] = [:] 
    static var work: [String : AnyObject] = [:] {
        didSet {
            companyKeys = Array(work.keys).sorted()
        }
    }
    static var companyKeys: [String] = []
    static var school: [String : AnyObject] = [:] {
        didSet {
            schoolNameKeys = Array(school.keys).sorted()
        }
    }
    static var schoolNameKeys: [String] = []

//    func deleteImages() {
//        let fileManager = FileManager.default
//        let myDocuments = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        do {
//            try fileManager.removeItem(at: myDocuments)
//        } catch {
//            return
//        }
//    }
//
//    func contentsOfDocumentsDirectory() {
//        do {
//            let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let docs = try FileManager.default.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: [], options:  [.skipsHiddenFiles, .skipsSubdirectoryDescendants])
//            print(docs)
//        } catch {
//            print(error)
//        }
//    }
    
    //MARK: Populate Data
    static func checkFirebaseForReset() {
        firebaseReset() { reset in
            //print("Check Firebase reset: \(reset)")
            (reset == true) ? UserDefaults.standard.set(false, forKey: "CoreData") : nil
            print("Reset from Firebase? ",reset)
            populateData(from: reset)
        }
    }
    
    static func populateData(from reset: Bool) {
        if !reset && coreDataPopulated() {
            print("Load from CoreData")
            loadProfile()
            loadOverview()
            loadWork()
            loadSchool()
        }
        else {
            print("Load from Firebase")
            firebaseAll {
                UserDefaults.standard.set(true, forKey: "CoreData")
            }
        }
    }
    
    //MARK: UserDefaults
    static func coreDataPopulated() -> Bool {
        return UserDefaults.standard.bool(forKey: "CoreData")
    }
    
        
    
}

