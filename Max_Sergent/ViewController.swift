//
//  ViewController.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/6/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ViewController: UIViewController {
    
    let testing = Testing()
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        print("Hello World!")
        setup()
        retrieveData()
    }
    
    //MARK: Setup
    func setup() {
        objectSettings()
        constraints()
    }
    
    //MARK: Settings
    func objectSettings() {
        view.addSubview(testing)
        testing.setup()
        testing.addToFirebase.addTarget(self, action: #selector(sendData), for: .touchUpInside)
    }
    
    //MARK: Constraints
    func constraints() {
        testing.translatesAutoresizingMaskIntoConstraints                                                           = false
        testing.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive                                 = true
        testing.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive                               = true
        testing.topAnchor.constraint(equalTo: self.view.topAnchor).isActive                                         = true
        testing.heightAnchor.constraint(equalToConstant: 600).isActive                                              = true
    }
    
    //MARK: Functionality
    @objc func sendData() {
        let dataType = "user"
        let name = "Max Sergent"
        let desiredCompany = "Capital One"
        let dictionary = toAnyObject(name: name, desiredCompany: desiredCompany)
        let refItem = ref.child(dataType.lowercased())
        refItem.setValue(dictionary)
        
        testing.displayFirebase.text = "\(dataType): \(name) - \(desiredCompany)"
    }
    
    func retrieveData() {
        //ref.observe(.value, with: { snapshot in
        //  print(snapshot.value as Any)
        //})
        let background = DispatchQueue.global()
        background.sync {print("retrieving --")}
        ref.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot {
                    self.alterLabel(snapshot: snapshot)
                }
            }
        })
    }
    
    func alterLabel(snapshot: DataSnapshot) {
        print("trying to alter label")
        if let value = snapshot.value as? [String: AnyObject]
            , let name = value["name"] as? String
            , let desiredCompany = value["desiredCompany"] as? String
            , let completed = value["completed"] as? Bool {
            self.testing.displayFirebase.text = "\(snapshot.key): \(name) - \(desiredCompany) - \(completed)"
        }
        else {
            print("Error: snapshot failed, check keys provided.")
        }
    }
    
    func toAnyObject(name: String, desiredCompany: String, completed: Bool? = false) -> Any {
      return [
        "name": name,
        "desiredCompany": desiredCompany,
        "completed": completed!
      ]
    }
    
}
