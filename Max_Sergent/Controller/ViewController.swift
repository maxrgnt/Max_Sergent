//
//  ViewController.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import MapKit

class ViewController: UIViewController, DataDelegate, HeaderDelegate, ScrollDelegate, OverviewDelegate, MenuDelegate, MFMailComposeViewControllerDelegate {
    
    let splash = Splash()
    let watermark = UILabel()
    static let lastUpdate = UILabel()
    let header = Header()
    let scroll = Scroll()
    let footer = Footer()
    
    let mailComposerVC = MFMailComposeViewController()
    var statusBarStyle: UIStatusBarStyle = .darkContent
    
    override func viewDidLoad() {
        Data.customDelegate = self
        
        view.addSubview(splash)
        splashConstraints()
        splash.setup() {
            splash.constraints()
            splash.animate()
        }
        Data.checkFirebaseForReset()
        
        print("Hello World!")
        Sizing.padding = Sizing.padding < 22.0 ? 22.0 : Sizing.padding
        Sizing.offsetForShorterScreens = Sizing.height <= 736.0 ? -66.0 : 0.0
        
        print(Date())
        setup() {
            constraints()
            Data.clearAllDataForTesting()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // App background color is light, whether in light or dark mode make status bar dark.
        return self.statusBarStyle
    }

    //MARK: Settings
    func setup(closure: () -> Void) {
        
        view.insertSubview(watermark, belowSubview: splash)
        watermark.alpha            = 1.0
        watermark.numberOfLines    = 2
        watermark.textAlignment    = .center
        watermark.backgroundColor  = .clear
        watermark.lineBreakMode    = .byClipping
        watermark.font             = Fonts.Header.name
        
        view.insertSubview(ViewController.lastUpdate, belowSubview: splash)
        ViewController.lastUpdate.alpha           = 1.0
        ViewController.lastUpdate.numberOfLines   = 2
        ViewController.lastUpdate.textAlignment   = .center
        ViewController.lastUpdate.backgroundColor = .clear
        ViewController.lastUpdate.lineBreakMode   = .byClipping
        ViewController.lastUpdate.font            = Fonts.Overview.title
        
        view.insertSubview(header, belowSubview: splash)
        header.setup() {
            header.constraints()
            header.resetNameHeight()
        }
        header.customDelegate = self
        
        view.insertSubview(scroll, belowSubview: splash)
        scroll.setup() {
            scroll.constraints()
            scroll.resetContentInset()
        }
        scroll.customDelegate = self
        scroll.page1.customDelegate = self
        
        view.insertSubview(footer, belowSubview: splash)
        footer.setup() {
            footer.constraints()
        }
        footer.menu.customDelegate = self
        
        closure()
    }
    
    //MARK: Custom Delegates
    func scrollSet(toPage page: Int) {
        if footer.menu.currentPage != page {
            footer.menu.currentPage = page
            footer.menu.setAlphaForPage()
            footer.menu.canSetFromMenu = true
            updateForChange(toPage: page)
        }
    }
    
    func menuSet(toPage page: Int) {
        footer.menu.canSetFromMenu = false
        let newX = Sizing.width * CGFloat(page)
        let newOffset = CGPoint(x: newX, y: 0.0)
        scroll.setContentOffset(newOffset, animated: true)
    }
    
    func updateForChange(toPage page: Int) {
        header.isUserInteractionEnabled = (scroll.contentOffset.x == 0.0) ? true : false
        (page != 1) ? scroll.page2.setContentOffset(CGPoint.zero, animated:true) : nil
        (page != 2) ? scroll.page3.setContentOffset(CGPoint.zero, animated:true) : nil
        self.statusBarStyle = (page == 0) ? .darkContent : .lightContent
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func calculateRatio(for contentOffset: CGFloat) {
        // If contentOffset negative, do not let menu interaction occur
        footer.isUserInteractionEnabled = (contentOffset < 0.0) ? false : true
        // The scale factor is inversely related to the ratio of the currentOffset.x to Scroll.width
        // If the scrollview has been offset 20% the scale factor should be 80%
        // As the scrollview moves right the scale factor shrinks the header
        let inverseScalar = (contentOffset/Sizing.Scroll.limit)
        var directScalar = 1-(contentOffset/Sizing.width)
        // If the scale factor goes negative, reset to zero
        directScalar = (directScalar <= 0) ? 0.0 : directScalar
        
        header.scaleDirectly(with: directScalar)
        header.scaleInversely(with: inverseScalar)
        scroll.scaleInversely(with: inverseScalar)
    }
    
    func openMaps() {
        let myAddress = Data.overview[Constants.Data_Key.locationBackEnd]!
        if let url = URL(string:"http://maps.apple.com/?address=\(myAddress)") {
            UIApplication.shared.open(url)
        } else {
            let hapticFeedback = UINotificationFeedbackGenerator()
            hapticFeedback.notificationOccurred(.error)
        }
    }
    
    //MARK: Third-Party Navigators
    func sendEmail() {
        let email = Data.overview[Constants.Data_Key.email]!
        let subject = Data.overview[Constants.Data_Key.email_subject]!
        let bodyText = Data.overview[Constants.Data_Key.email_body]!
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email])
            mail.setSubject(subject)
            mail.setMessageBody(bodyText, isHTML: true)
            present(mail, animated: true)
        } else {
            let coded = "mailto:\(email)?subject=\(subject)&body=\(bodyText)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let emailURL = URL(string: coded!) {
              if UIApplication.shared.canOpenURL(emailURL) {
                  UIApplication.shared.open(emailURL, options: [:], completionHandler: { (result) in
                      if !result {
                          let hapticFeedback = UINotificationFeedbackGenerator()
                          hapticFeedback.notificationOccurred(.error)
                      }
                  })
              }
            }
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    func openLinkedIn() {
        let webURL = URL(string: Data.overview[Constants.Data_Key.linkedinWebURL]!)!
        let appURL = URL(string: Data.overview[Constants.Data_Key.linkedinAppURL]!)!
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: Data Logic
    func reloadingFirebase() {
        self.view.bringSubviewToFront(self.splash)
        UIView.animate(withDuration: 0.55, delay: 0.0,
            // 1.0 is smooth, 0.0 is bouncy
            usingSpringWithDamping: 0.7,
            // 1.0 corresponds to the total animation distance traversed in one second
            // distance/seconds, 1.0 = total animation distance traversed in one second
            initialSpringVelocity: 1.0,
            options: [.curveEaseInOut],
            // [autoReverse, curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear]
            animations: {
                //Do all animations here
                self.splash.alpha = 1
        }, completion: {
               //Code to run after animating
                (value: Bool) in
            self.splash.animate()
            }
        )
        let backgroundQueue = DispatchQueue(label: "com.app.queue", qos: .background)
        backgroundQueue.async {
            print("Run on background thread")
            Data.dataLoadTracker()
        }
        DispatchQueue.main.async {
            self.checkIfAllDataLoaded()
            print("This is run on the main queue, after the previous code in outer block")
        }
    }
    
    func checkIfAllDataLoaded() {
        print("VC checking with Data if all data loaded...")
        if Data.allDataLoaded {
            print("All data has been loaded, reset views!")
            allDataLoaded()
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Change `2.0` to the desired number of seconds.
                self.checkIfAllDataLoaded()
            }
        }
    }
    
    func allDataLoaded() {
        resetAppInfo()
        resetColorScheme()
        resetOverview()
        resetTimeline()
        resetFuture()
        resetConcepts()
        resetPieData()
        UIView.animate(withDuration: 0.55, delay: 0.0,
            // 1.0 is smooth, 0.0 is bouncy
            usingSpringWithDamping: 0.7,
            // 1.0 corresponds to the total animation distance traversed in one second
            // distance/seconds, 1.0 = total animation distance traversed in one second
            initialSpringVelocity: 1.0,
            options: [.curveEaseInOut],
            // [autoReverse, curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear]
            animations: {
                //Do all animations here
                self.splash.alpha = 0
        }, completion: {
               //Code to run after animating
                (value: Bool) in
            self.view.subviews.forEach({$0.layer.removeAllAnimations()})
            self.view.layer.removeAllAnimations()
            self.splash.sendSubviewToBack(self.splash)
            self.splash.title.alpha = 0.0
            }
        )
    }
    
    func resetAppInfo() {
        let watermarkList  = (Data.appInfo[Constants.Data_Key.watermark] as! String).split(separator: " ")
        let watermarkStr   = "\(watermarkList[0])\n\(watermarkList[1])"
        watermark.text     = watermarkStr
        let userNameList   = (Data.appInfo[Constants.Data_Key.userName]  as! String).split(separator: " ")
        let userName       = "\(userNameList[0])\n\(userNameList[1])"
        header.name.text   = userName
        header.photo.image = (Data.appInfo[Constants.Data_Key.appInfoPhoto]  as! UIImage)
        header.resetNameHeight()
    }
    
    func resetOverview() {
        Data.overviewTable = [(title: Constants.Overview.titles[0],
                               boxes: [(icon: "",
                                        content: Data.overview[Constants.Data_Key.objective]!)]),
                              (title: Constants.Overview.titles[1],
                               boxes: [(icon: Constants.Overview.contactIcons[0],
                                        content: Data.overview[Constants.Data_Key.locationFrontEnd]!),
                                       (icon: Constants.Overview.contactIcons[1],
                                        content: Data.overview[Constants.Data_Key.email]!),
                                       (icon: Constants.Overview.contactIcons[2],
                                        content: Data.overview[Constants.Data_Key.linkedinWebURL]!)])]
        scroll.page1.reloadData()
    }
    
    func resetTimeline() {
        Data.timelineTable = []
        var years: [Int] = []
        Data.timeline.keys.forEach { key in
            let year = Data.timeline[key]![Constants.Data_Key.year]
            !years.contains(year as! Int) ? years.append(year as! Int) : nil
        }
        years = years.sorted().reversed()
        years.forEach { year in
            var events: [[String: Any]] = []
            Data.timeline.keys.forEach { key in
                let data = Data.timeline[key]!
                if data[Constants.Data_Key.year] as! Int == year {
                    events.append([Constants.Data_Key.organization: data[Constants.Data_Key.organization] as! String,
                                   Constants.Data_Key.details: data[Constants.Data_Key.details] as! String,
                                   Constants.Data_Key.type: data[Constants.Data_Key.type] as! String,
                                   Constants.Data_Key.iconName: data[Constants.Data_Key.iconName] as! String,
                                   Constants.Data_Key.index: data[Constants.Data_Key.index] as! Int])
                }
            }
            Data.timelineTable.append([Constants.Data_Key.year: String(describing: year),
                                       Constants.Data_Key.events: events])
        }
        for (i, object) in Data.timelineTable.enumerated() {
            let key = Constants.Data_Key.index
            let unsorted = object[Constants.Data_Key.events]
            let sorted = (unsorted as! NSArray).sortedArray(using: [NSSortDescriptor(key: key, ascending: false)]) as! [[String:AnyObject]]
            Data.timelineTable[i][Constants.Data_Key.events] = sorted
        }
        scroll.page2.reloadData()
    }
    
    func resetFuture() {
        print(Data.futureYear)
        print(Data.future)
        (scroll.page2.refreshControl?.subviews[1] as! TimelineRefresh).title.text = Data.futureYear
        (scroll.page2.refreshControl?.subviews[1] as! TimelineRefresh).icons = Data.future
    }
    
    func resetPieData() {
        let key = Constants.Data_Key.index
        let unsorted = Data.pie
        let sorted = (unsorted as NSArray).sortedArray(using: [NSSortDescriptor(key: key, ascending: true)]) as! [[String:AnyObject]]
        Data.pie = sorted
        scroll.page3.pie.resetPieData()
        let datePieces = Data.pieOriginDate.split(separator: " ")
        scroll.page3.originDate.text = "\(datePieces[0])\n\(datePieces[1])\n\(datePieces[2])"
        // Calls the overided draw function
        scroll.page3.pieText.setNeedsDisplay()
    }
    
    func resetConcepts() {
        let key = Constants.Data_Key.title
        let unsorted = Data.concepts
        let sorted = (unsorted as NSArray).sortedArray(using: [NSSortDescriptor(key: key, ascending: true)]) as! [[String:AnyObject]]
        Data.concepts = sorted
        scroll.page3.concepts.collection.reloadData()
        scroll.page3.concepts.resize()
        scroll.page3.resize()
    }
    
}
