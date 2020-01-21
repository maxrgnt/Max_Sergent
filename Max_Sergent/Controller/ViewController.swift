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
    
    let watermark = UILabel()
    let header = Header()
    let scroll = Scroll()
    let footer = Footer()
    
    let mailComposerVC = MFMailComposeViewController()
    
    override func viewDidLoad() {
        print("Hello World!")
        Sizing.padding = Sizing.padding < 22.0 ? 22.0 : Sizing.padding
        Sizing.offsetForShorterScreens = Sizing.height <= 736.0 ? -66.0 : 0.0
        
        view.backgroundColor = Colors.ViewController.background
        setup() {
            constraints()
            Data.clearAllDataForTesting()
            Data.checkFirebaseForReset()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // App background color is light, whether in light or dark mode make status bar dark.
        return .darkContent
    }

    //MARK: Settings
    func setup(closure: () -> Void) {
        
        Data.customDelegate = self
        
        view.addSubview(watermark)
        watermark.alpha            = 0.7
        watermark.numberOfLines    = 2
        watermark.textAlignment    = .center
        watermark.backgroundColor  = .clear
        watermark.lineBreakMode    = .byClipping
        watermark.font             = Fonts.Header.name
        watermark.textColor        = Colors.ViewController.watermark
        watermark.text             = Constants.watermark
        
        view.addSubview(header)
        header.setup() {
            header.constraints()
            header.resetNameHeight()
        }
        header.customDelegate = self
        view.addSubview(scroll)
        scroll.setup() {
            scroll.constraints()
            scroll.resetContentInset()
        }
        scroll.customDelegate = self
        scroll.page1.customDelegate = self
        view.addSubview(footer)
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
        }
    }
    
    func menuSet(toPage page: Int) {
        footer.menu.canSetFromMenu = false
        let newX = Sizing.width * CGFloat(page)
        let newOffset = CGPoint(x: newX, y: 0.0)
        scroll.setContentOffset(newOffset, animated: true)
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
    func resetAppInfo() {
        let watermarkList  = (Data.appInfo[Constants.Data_Key.watermark] as! String).split(separator: " ")
        let watermarkStr   = "\(watermarkList[0])\n\(watermarkList[1])"
        watermark.text     = watermarkStr
        let userNameList   = (Data.appInfo[Constants.Data_Key.userName]  as! String).split(separator: " ")
        let userName       = "\(userNameList[0])\n\(userNameList[1])"
        header.name.text   = userName
        header.photo.image = (Data.appInfo[Constants.Data_Key.appInfoPhoto]  as! UIImage)
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
        print(Data.overview)
    }
}
