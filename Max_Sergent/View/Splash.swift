//
//  Splash.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/21/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Splash: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    var photoHeight: NSLayoutConstraint!
    var photoWidth: NSLayoutConstraint!
    // Objects
    var photo = UIImageView()
    var title = UILabel()
    
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
        
        backgroundColor = .white
        clipsToBounds   = true
        
        addSubview(photo)
        photo.clipsToBounds       = true
        photo.layer.masksToBounds = true
        photo.contentMode         = .scaleAspectFill
        photo.image               = UIImage(named: Constants.Placeholder.photoURL)
        
        addSubview(title)
        title.numberOfLines   = 1
        title.textAlignment   = .center
        title.backgroundColor = .clear
        title.lineBreakMode   = .byClipping
        title.font            = Fonts.Splash.title
        title.text            = Constants.splashTitle
        title.textColor       = .black
        title.alpha           = 0.0
        
        closure()
    }
    
    func animate() {
        self.layoutIfNeeded()
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
                self.photoHeight.constant = Sizing.width*Constants.splashLarge
                self.photoWidth.constant = Sizing.width*Constants.splashLarge
                self.layoutIfNeeded()
        }, completion: {
               //Code to run after animating
                (value: Bool) in
            // SHOW TITLE
            UIView.animate(withDuration: 0.55,
                animations: {
                    self.title.alpha = 1.0
            })
            // BEGIN REPEATING GESTATION
            UIView.animate(withDuration: 0.55, delay: 0.0,
                // 1.0 is smooth, 0.0 is bouncy
                usingSpringWithDamping: 0.7,
                // 1.0 corresponds to the total animation distance traversed in one second
                // distance/seconds, 1.0 = total animation distance traversed in one second
                initialSpringVelocity: 1.0,
                options: [.curveEaseInOut, .repeat, .autoreverse],
                // [autoReverse, curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear]
                animations: {
                    //Do all animations here
                    self.photoHeight.constant = Sizing.width*Constants.splashSmall
                    self.photoWidth.constant = Sizing.width*Constants.splashSmall
                    self.layoutIfNeeded()
            })
        }
    )}

}
