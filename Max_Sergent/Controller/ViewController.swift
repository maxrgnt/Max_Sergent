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

class ViewController: UIViewController, ScrollDelegate {
    
    let header = Header()
    let scroll = Scroll()
    let ref = Database.database().reference()
//    let storage = Storage.storage(url:"gs://max-sergent-45387.appspot.com")
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    // Create a storage reference from our storage service
    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        print("Hello World!")
        view.backgroundColor = UI.Colors.Header.background
        setup()
        //retrieveData()
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
        view.addSubview(scroll)
        scroll.setup()
        scroll.customDelegate = self
    }
    
    //MARK: Constraints
    func constraints() {
        headerConstraints()
        scrollConstraints()
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
    
    //MARK: Custom Delegates
    func adjustHeader(toHeight newConstant: CGFloat) {
        var newDiameter = newConstant - UI.Sizing.Header.pictureDiameter - UI.Sizing.Header.padding
        var newAlpha = newDiameter / UI.Sizing.Header.pictureDiameter
        newAlpha = (newAlpha > 1) ? 1.0 : newAlpha
        newAlpha = (newAlpha < 0) ? 0.0 : newAlpha
        newDiameter = (newDiameter <= 0) ? 0 : newDiameter
        var adjFontHeight = newConstant - UI.Sizing.Header.padding
        adjFontHeight = (adjFontHeight >= UI.Sizing.Header.expandedNameHeight) ? UI.Sizing.Header.expandedNameHeight : adjFontHeight
        header.height.constant = newConstant
        header.pictureHeight.constant = newDiameter
        header.pictureWidth.constant = newDiameter
        header.picture.alpha = newAlpha
        scroll.overview.alpha = newAlpha
        header.picture.layer.cornerRadius = newDiameter/2
        let x = UI.Sizing.Header.expandedHeight/UI.Sizing.Header.minimizedHeight
        let y = header.height.constant/UI.Sizing.Header.minimizedHeight
        header.name.alpha = (newConstant == UI.Sizing.Header.minimizedHeight) ? 1.0 : (y-1)/x
        let z = header.height.constant/UI.Sizing.Header.expandedHeight
        let zz = 1-((z-1)/(UI.Sizing.Scroll.limit/UI.Sizing.Scroll.width))
        header.name.alpha = (newConstant > UI.Sizing.Header.expandedHeight) ? zz : header.name.alpha
        header.nameHeight.constant = adjFontHeight
        header.layoutIfNeeded()
        header.name.sizeToFit()
        let newAlignment: NSTextAlignment = (newConstant == UI.Sizing.Header.minimizedHeight) ? .center : .left
        if header.name.textAlignment != newAlignment {
            header.name.alpha = 0.0
            header.name.textAlignment = newAlignment
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut
                , animations: ({
                    self.header.name.alpha = 1.0
                }))
        }
    }
    
    func poop(toHeight newConstant: CGFloat) {
        print("-: ",header.height.constant, newConstant)
        header.height.constant = newConstant
        print("-: ",scroll.bounds)
        print("-: ",scroll.contentOffset)
//        print("------------------------")
//        header.layoutIfNeeded()
    }
}
