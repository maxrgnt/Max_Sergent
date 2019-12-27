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
    let menu = Menu()
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
        populateExperience()
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
        view.addSubview(menu)
        menu.setup()
        view.addSubview(scroll)
        scroll.setup()
        scroll.customDelegate = self
    }
    
    //MARK: Constraints
    func constraints() {
        headerConstraints()
        header.layoutIfNeeded()
        menuConstraints()
        menu.layoutIfNeeded()
        scrollConstraints()
        scroll.overview.layoutIfNeeded()
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
                    if let value = snapshot.value as? [String: AnyObject],
                        let tracker = value["overviewTracker"] as? [String: AnyObject],
                        let origin = tracker["originDate"] as? String,
                        let personal_swift = tracker["personal"]!["swift"] as? CGFloat,
                        let personal_python = tracker["personal"]!["python"] as? CGFloat,
                        let work_sql = tracker["work"]!["sql"] as? CGFloat {
                            let daysFromOrigin = self.numberOfDays(since: origin)
                            let personalEmpty = daysFromOrigin-personal_swift-personal_python
                            let work_empty = daysFromOrigin-work_sql
                            self.getDays(forBars: ["side":[personal_swift,personal_python, personalEmpty],
                                                   "work":[work_sql, work_empty]])
                    }
                }
            }
        })
    }
    
    func populateExperience() {
        for key in Data.experience.keys {
            print(key, Data.experience[key]!)
        }
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
    
    func numberOfDays(since origin: String) -> CGFloat {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: origin) // "01/01/2019"
        let diff = Date().interval(ofComponent: .day, fromDate: date!)
        return CGFloat(diff)
    }
    
    func getDays(forBars bars: [String:[CGFloat]]) {
        let side_swift = bars["side"]![0]
        let side_python = bars["side"]![1]
        let side_empty = bars["side"]![2]
        let totalDays = side_swift+side_python+side_empty
        let w = UI.Sizing.Overview.barWidth
        scroll.overview.personal_swiftWidth.constant = w*(side_swift/totalDays)
        scroll.overview.personal_pythonWidth.constant = w*(side_python/totalDays)
        scroll.overview.personal_emptyWidth.constant = w*(side_empty/totalDays)
        let work_sql = bars["work"]![0]
        let work_empty = bars["work"]![1]
        scroll.overview.work_sqlWidth.constant = w*(work_sql/totalDays)
        scroll.overview.work_emptyWidth.constant = w*(work_empty/totalDays)
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveEaseInOut
        , animations: ({
            self.scroll.overview.personalStats.text = "Swift: \(Int(side_swift)) days | Python: \(Int(side_python)) days"
            self.scroll.overview.workStats.text = "SQL: \(Int(work_sql)) days"
            self.scroll.overview.layoutIfNeeded()
        }))
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
        scroll.experience.alpha = (1-newAlpha)
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
    
}
