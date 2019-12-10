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
import FirebaseStorage

class ViewController: UIViewController {
    
    let testing = Testing()
    let overview = Overview()
    let ref = Database.database().reference()
//    let storage = Storage.storage(url:"gs://max-sergent-45387.appspot.com")
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    // Create a storage reference from our storage service
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        print("Hello World!")
        view.backgroundColor = .black
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
        //view.addSubview(testing)
        //testing.setup()
        //testing.addToFirebase.addTarget(self, action: #selector(sendData), for: .touchUpInside)
        view.addSubview(overview)
        overview.setup()
    }
    
    //MARK: Constraints
    func constraints() {
//        testing.translatesAutoresizingMaskIntoConstraints                                                           = false
//        testing.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive                                 = true
//        testing.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive                               = true
//        testing.topAnchor.constraint(equalTo: self.view.topAnchor).isActive                                         = true
//        testing.heightAnchor.constraint(equalToConstant: 600).isActive                                              = true
        
        overviewConstraints()
    }
    
    //MARK: Functionality
    @objc func sendData() {
        let dataType = "user"
        let name = "Max Sergent"
        let desiredCompany = "Capital One"
        let imageURL = "gs://max-sergent-45387.appspot.com/linkedin.jpg"
        let completed = true
        let dictionary = toAnyObject(name: name, desiredCompany: desiredCompany, completed: completed, imageURL: imageURL)
        let refItem = ref.child(dataType.lowercased())
        refItem.setValue(dictionary)
        
        testing.displayFirebase.text = "\(dataType): \(name) - \(desiredCompany) - \(completed)"
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
            , let completed = value["completed"] as? Bool
            , let imageURL = value["imageURL"] as? String {
//            self.testing.displayFirebase.text = "\(snapshot.key): \(name) - \(desiredCompany) - \(completed)"
            
            print(imageURL)
            let reference = storage.reference(forURL: imageURL)
            reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let error = error {
                print(error)
                self.overview.picture.image = UIImage(named: "placeholder.jpg")
              } else {
                let image = UIImage(data: data!)
                self.overview.picture.image = image
              }
            }
        }
        else {
            print("Error: snapshot failed, check keys provided.")
        }
    }
    
    func toAnyObject(name: String, desiredCompany: String, completed: Bool? = false, imageURL: String) -> Any {
      return [
        "name": name,
        "desiredCompany": desiredCompany,
        "completed": completed!,
        "imageURL": imageURL
      ]
    }
    
}
