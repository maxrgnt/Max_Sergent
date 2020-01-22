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
                self.photoHeight.constant = Sizing.width*0.85
                self.photoWidth.constant = Sizing.width*0.85
                self.layoutIfNeeded()
        }, completion: {
               //Code to run after animating
                (value: Bool) in
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
                    self.photoHeight.constant = Sizing.width/2
                    self.photoWidth.constant = Sizing.width/2
                    self.layoutIfNeeded()
            })
        }
    )}

}
