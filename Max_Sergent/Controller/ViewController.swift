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
    
    let header = Header()
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
        view.addSubview(header)
        header.setup()
    }
    
    //MARK: Constraints
    func constraints() {
        headerConstraints()
    }
    
    //MARK: Functionality
    @objc func sendData() {
        let dataType = "user"
        let name = "Max Sergent"
        let imageURL = "gs://max-sergent-45387.appspot.com/linkedin.jpg"
        let dictionary = toAnyObject(name: name, imageURL: imageURL)
        let refItem = ref.child(dataType.lowercased())
        refItem.setValue(dictionary)
    }
    
    func retrieveData() {
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
            , let reset = value["reset"] as? Bool
            , let name = value["name"] as? String
            , let imageURL = value["imageURL"] as? String {
            if reset {
                let nameArray = name.split(separator: " ")
                self.header.name.text = "\(nameArray[0])\n\(nameArray[1])"
                let reference = storage.reference(forURL: imageURL)
                reference.getData(maxSize: 1 * 1024 * 1024) { data, error in
                  if let error = error {
                    print(error)
                    self.header.picture.image = UIImage(named: "placeholder.jpg")
                  } else {
                    let image = UIImage(data: data!)
                    self.header.picture.image = image
                  }
                }
            }
        }
        else {
            print("Error: snapshot failed, check keys provided.")
        }
    }
    
    func toAnyObject(name: String, reset: Bool? = true, imageURL: String) -> Any {
      return [
        "name": name,
        "imageURL": imageURL,
        "reset": reset!
      ]
    }
    
}
