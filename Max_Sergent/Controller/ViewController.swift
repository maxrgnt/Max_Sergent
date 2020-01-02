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

class ViewController: UIViewController, ScrollDelegate, MenuDelegate, DataDelegate {
    
    let header = Header()
    let menu = Menu()
    let scroll = Scroll()
    let ref = Database.database().reference()
//    let storage = Storage.storage(url:"gs://max-sergent-45387.appspot.com")
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    // Create a storage reference from our storage service
    let storageRef = Storage.storage().reference()
    
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        print("Hello World!")
        view.backgroundColor = UI.Colors.Header.background
        
        setup()
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            Data.checkFirebaseForReset()
        }else{
            print("Internet Connection not Available!")
            Data.populateData(from: false)
        }
        
        //retrieveData()
        //populateExperience()
        //Data.imageStuff()
        //Data.deleteImages()
        //Data.contentsOfDocumentsDirectory()
    }
    
    //MARK: Setup
    func setup() {
        objectSettings()
        constraints()
    }
    
    //MARK: Settings
    func objectSettings() {
        
        Data.customDelegate = self
        
        view.addSubview(header)
        header.setup()
        view.addSubview(menu)
        menu.setup()
        menu.customDelegate = self
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
    
    func populateExperience() {
//        for key in Data.experience.keys {
//            print(key, Data.experience[key]!)
//        }
    }
    
    func alterLabel(snapshot: DataSnapshot) {
        print("trying to alter label")
        if let value = snapshot.value as? [String: AnyObject]
            , let imageURL = value["imageURL"] as? String
        {
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
    
    func numberOfDays(since origin: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: origin) // "01/01/2019"
        let diff = Date().interval(ofComponent: .day, fromDate: date!)
        return Int(diff)
    }
    
    //MARK: Custom Delegates
    func adjustHeader(toHeight newHeight: CGFloat) {
        var newDiameter = newHeight - UI.Sizing.Header.pictureDiameter - UI.Sizing.Header.padding
        var newAlpha = newDiameter / UI.Sizing.Header.pictureDiameter
        newAlpha = (newAlpha > 1) ? 1.0 : newAlpha
        newAlpha = (newAlpha < 0) ? 0.0 : newAlpha
        newDiameter = (newDiameter <= 0) ? 0 : newDiameter
        var adjFontHeight = newHeight - UI.Sizing.Header.padding
        adjFontHeight = (adjFontHeight >= UI.Sizing.Header.expandedNameHeight)
            ? UI.Sizing.Header.expandedNameHeight
            : adjFontHeight
        
        header.height.constant = newHeight
        header.pictureHeight.constant = newDiameter
        header.pictureWidth.constant = newDiameter
        header.picture.alpha = newAlpha
        header.picture.layer.cornerRadius = newDiameter/2
        header.nameHeight.constant = adjFontHeight
        
        let expandedOverMinimizedRatio = UI.Sizing.Header.expandedHeight/UI.Sizing.Header.minimizedHeight
        let currentOverMinimizedRatio = header.height.constant/UI.Sizing.Header.minimizedHeight
        let currentOverExpandedRatio = header.height.constant/UI.Sizing.Header.expandedHeight
        let limitOverWidthRatio = UI.Sizing.Scroll.limit/UI.Sizing.Scroll.width
        let newNameAlpha = 1-((currentOverExpandedRatio-1)/limitOverWidthRatio)
        
        header.name.alpha = (newHeight == UI.Sizing.Header.minimizedHeight)
            ? 1.0
            : (currentOverMinimizedRatio-1)/expandedOverMinimizedRatio
        
        header.name.alpha = (newHeight > UI.Sizing.Header.expandedHeight) ? newNameAlpha : header.name.alpha
        menu.alpha = (newHeight > UI.Sizing.Header.expandedHeight) ? newNameAlpha : menu.alpha
        
        header.layoutIfNeeded()
        header.name.sizeToFit()
        let newAlignment: NSTextAlignment = (newHeight == UI.Sizing.Header.minimizedHeight) ? .center : .left
        
        if header.name.textAlignment != newAlignment {
            header.name.alpha = 0.0
            header.name.textAlignment = newAlignment
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           // 1.0 is smooth, 0.0 is bouncy
                           //usingSpringWithDamping: 0.5,
                           // 1.0 corresponds to the total animation distance traversed in one second
                           // distance/seconds, 1.0 = total animation distance traversed in one second
                           //initialSpringVelocity: 1.0,
                           options: [.curveEaseInOut],
                           // [autoReverse, curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear]
                animations: ({
                    self.header.name.alpha = 1.0
                }))
        }
    }
    
    func menuMoveScroll(toPage page: Int) {
        if currentPage != page {
            let newX = UI.Sizing.Scroll.width * CGFloat(page)
            let newOffset = CGPoint(x: newX, y: 0.0)
            self.scroll.setContentOffset(newOffset, animated: true)
        }
    }
    
    func scrollMoveMenu(toPage page: Int) {
        if currentPage != page {
            currentPage = page
            menu.labels.forEach { (label) in
                label.font = (label.tag == page)
                    ? UI.Fonts.Menu.selected
                    : UI.Fonts.Menu.normal
                label.alpha = (label.tag == page)
                    ? 1.0
                    : 0.7
            }
        }
    }
    
    func reloadProfile() {
        let pieces = Data.profile.name.split(separator: " ")
        header.name.text = "\(pieces[0])\n\(pieces[1])"
        header.picture.image = Data.profile.picture
        header.picture.setNeedsDisplay()
    }
    
    func reloadWork() {
        scroll.work.table.reloadData()
    }
    
    func reloadOverview() {
        if  let statement = Data.overview[Constants.Data.Overview.statement] as? String,
            let originDate = Data.overview[Constants.Data.Overview.originDate] as? String,
            let personal = Data.overview[Constants.Data.Overview.personalProjects] as? [String: AnyObject],
            let work = Data.overview[Constants.Data.Overview.workProjects] as? [String: AnyObject]
        {
            let dateFormatterIn = DateFormatter()
            dateFormatterIn.dateFormat = "dd-MM-yyyy"

            let dateFormatterOut = DateFormatter()
            dateFormatterOut.dateFormat = "MMM,yyyy"

            guard let date = dateFormatterIn.date(from: originDate) else {
                print("There was an error decoding the originDate")
                return
            }
            
            let dateComponents = Calendar.current.component(.day, from: date)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .ordinal
            guard let day = numberFormatter.string(from: dateComponents as NSNumber) else {
                print("Number formattter not working")
                return
            }

            let pieces = dateFormatterOut.string(from: date).split(separator: ",")
            let largeFont = UI.Fonts.Overview.originDateMain
            let superScriptFont = UI.Fonts.Overview.originDateSuper
            let attrString = NSMutableAttributedString(string: "Since \(pieces[0]) \(day.dropLast(2))", attributes: [.font: largeFont!])
            attrString.append(NSAttributedString(string: "\(day.suffix(2))", attributes: [.font: superScriptFont!, .baselineOffset: 10]))
            attrString.append(NSAttributedString(string: " \(pieces[1]):", attributes: [.font: largeFont!]))
            scroll.overview.originDate.attributedText = attrString
            
            scroll.overview.objective.text = statement
            let daysFromOrigin = numberOfDays(since: originDate)
            scroll.overview.buildProjectBar(for: personal,
                                            since: daysFromOrigin,
                                            anchoredTo: scroll.overview.personalBar)
            scroll.overview.buildProjectLabel(for: personal, changing: scroll.overview.personalStats)
            scroll.overview.buildProjectBar(for: work,
                                            since: daysFromOrigin,
                                            anchoredTo: scroll.overview.workBar)
            scroll.overview.buildProjectLabel(for: work, changing: scroll.overview.workStats)
            //print(work)
        }
    }
    
}
