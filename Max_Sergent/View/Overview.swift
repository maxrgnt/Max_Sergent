//
//  Overview.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/14/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Overview: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    var box1Height: NSLayoutConstraint!
    var title1Height: NSLayoutConstraint!
    var objectiveHeight: NSLayoutConstraint!
    var box2Height: NSLayoutConstraint!
    var title2Height: NSLayoutConstraint!
    var emailHeight: NSLayoutConstraint!
    var emailIconHeight: NSLayoutConstraint!
    var emailIconWidth: NSLayoutConstraint!
    var box3Height: NSLayoutConstraint!
    var title3Height: NSLayoutConstraint!
    var locationHeight: NSLayoutConstraint!
    var locationIconHeight: NSLayoutConstraint!
    var locationIconWidth: NSLayoutConstraint!
    // Objects
    var box1 = UIView()
    var title1 = UILabel()
    var objective = UILabel()
    var box2 = UIView()
    var title2 = UILabel()
    var emailIcon = UIImageView()
    var emailText = UILabel()
    var box3 = UIView()
    var locationIcon = UIImageView()
    var locationText = UILabel()
    lazy var boxes = [box1, box2, box3]
    lazy var titles = [title1, title2]
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
        
        for box in boxes {
            addSubview(box)
            box.backgroundColor = Colors.Overview.box
            box.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Overview.boxRadius)
        }

        for (i, title) in titles.enumerated() {
            addSubview(title)
            title.numberOfLines   = 1
            title.textAlignment   = .left
            title.backgroundColor = .clear
            title.lineBreakMode   = .byWordWrapping
            title.font            = Fonts.Overview.boxTitle
            title.text            = Constants.Overview.titles[i]
            title.textColor       = Colors.Overview.boxTitle
        }
        
        box1.addSubview(objective)
        objective.numberOfLines   = 0
        objective.textAlignment   = .left
        objective.backgroundColor = .clear
        objective.lineBreakMode   = .byWordWrapping
        objective.font            = Fonts.Overview.boxContent
        objective.text            = Constants.Overview.objective
        objective.textColor       = Colors.Overview.boxContent
        
        box2.addSubview(emailIcon)
        emailIcon.clipsToBounds       = true
        emailIcon.layer.masksToBounds = true
        emailIcon.contentMode         = .scaleAspectFill
        emailIcon.image               = UIImage(named: Constants.Overview.contactIcons[0])
        
        box2.addSubview(emailText)
        emailText.numberOfLines   = 0
        emailText.textAlignment   = .left
        emailText.backgroundColor = .clear
        emailText.lineBreakMode   = .byWordWrapping
        emailText.font            = Fonts.Overview.boxContent
        emailText.text            = Constants.Overview.contactText[0]
        emailText.textColor       = Colors.Overview.boxContent
        
        box3.addSubview(locationIcon)
        locationIcon.clipsToBounds       = true
        locationIcon.layer.masksToBounds = true
        locationIcon.contentMode         = .scaleAspectFill
        locationIcon.image               = UIImage(named: Constants.Overview.contactIcons[1])
        
        box3.addSubview(locationText)
        locationText.numberOfLines   = 0
        locationText.textAlignment   = .left
        locationText.backgroundColor = .clear
        locationText.lineBreakMode   = .byWordWrapping
        locationText.font            = Fonts.Overview.boxContent
        locationText.text            = Constants.Overview.contactText[1]
        locationText.textColor       = Colors.Overview.boxContent
        
        closure()
    }
    
    func resetObjectiveHeight() {
        let frame = objective.frameForLabel(text: objective.text!,
                                            font: objective.font!,
                                            numberOfLines: objective.numberOfLines,
                                            width: Sizing.Overview.boxPaddedWidth)
        Sizing.Overview.objectiveHeight = frame.height
        objectiveHeight.constant        = frame.height
        box1Height.constant       = Sizing.Overview.box1Height
        
        let contactFrame = emailText.frameForLabel(text: emailText.text!,
                                                   font: emailText.font!,
                                                   numberOfLines: emailText.numberOfLines,
                                                   width: Sizing.Overview.boxPaddedWidth)
        Sizing.Overview.contactHeight = contactFrame.height
        emailHeight.constant          = contactFrame.height
        emailIconHeight.constant      = contactFrame.height
        emailIconWidth.constant       = contactFrame.height
        box2Height.constant           = Sizing.Overview.box2Height
        locationHeight.constant       = contactFrame.height
        locationIconHeight.constant   = contactFrame.height
        locationIconWidth.constant    = contactFrame.height
        box3Height.constant           = Sizing.Overview.box3Height
        
        let titleFrame = objective.frameForLabel(text: title1.text!,
                                                 font: title1.font!,
                                                 numberOfLines: title1.numberOfLines,
                                                 width: Sizing.Overview.boxPaddedWidth)
        title1Height.constant = titleFrame.height
        title2Height.constant = titleFrame.height
        layoutIfNeeded()
    }
    
}
