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
    
    static var profile: (name: String, picture: String) = (name: "", picture: "")
    static var overview: (originDate: String, statement: String, personal: [(language: String, days: Int)], work: [(language: String, days: Int)]) = (originDate: "", statement: "", personal: [], work: [])
    static var work: [String : AnyObject] = [:]
    
    static let experience: [String : [(position: String, work: String)]] =
        ["BEA":
            [(position: "Analyst", work: "I was lucky — I found what I loved to do early in life. Woz and I started Apple in my parents’ garage when I was 20. We worked hard, and in 10 years Apple had grown from just the two of us in a garage into a $2 billion company with over 4,000 employees."),
             (position: "Economist", work: "We had just released our finest creation — the Macintosh — a year earlier, and I had just turned 30. And then I got fired. How can you get fired from a company you started? Well, as Apple grew we hired someone who I thought was very talented to run the company with me, and for the first year or so things went well. ")],
        "Toggle":
            [(position: "Co-Founder", work: "But then our visions of the future began to diverge and eventually we had a falling out. When we did, our Board of Directors sided with him. So at 30 I was out. And very publicly out. What had been the focus of my entire adult life was gone, and it was devastating.")]
        ]
     
//    func imageStuff() {
//        if let success = UIImage(named: "placeholder.png")?.saveImage(as: "placeholder") {
//
//        }
//        if let image = loadImage(named: "placeholder") {
//            print("loaded")
//            print(image)
//        }
//    }
//
//    func loadImage(named: String) -> UIImage? {
//        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
//            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
//        }
//        return nil
//    }
//
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

