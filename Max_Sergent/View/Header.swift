//
//  Header.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Header: UIView {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    var height:     NSLayoutConstraint!
    var nameHeight: NSLayoutConstraint!
    var nameBottom: NSLayoutConstraint!
    // Objects
    var photo    = UIImageView()
    var name     = UILabel()
    var gradient = CAGradientLayer()
    
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
        backgroundColor = Colors.Header.background
        clipsToBounds   = true
        
        addSubview(photo)
        photo.clipsToBounds       = true
        photo.layer.masksToBounds = true
        photo.contentMode         = .scaleAspectFill
        photo.image               = UIImage(named: Constants.Header.photo)
        
        buildGradient()
        
        addSubview(name)
        name.numberOfLines             = 2
        name.textAlignment             = .left
        name.backgroundColor           = .clear
        name.lineBreakMode             = .byClipping
        //name.minimumScaleFactor        = 0.1
        //name.adjustsFontSizeToFitWidth = true
        name.font                      = Fonts.Header.name
        name.textColor                 = Colors.Header.name
        name.text                      = Constants.Header.name
        
        closure()
    }
    
    func buildGradient() {
        // Set origin of gradient (top left of screen)
        let gradientOrigin = CGPoint(x: 0, y: 0.0)
        // Set frame of gradient (header height, because status bar will be solid color)
        let gradientSize   = CGSize(width: Sizing.width, height: Sizing.Header.expandedHeight)
        gradient.frame     = CGRect(origin: gradientOrigin, size: gradientSize)
        // Set color progression for gradient, alphaComponent of zero important for color shifting to
        gradient.colors    = [Colors.Header.gradient.withAlphaComponent(0.0).cgColor,
                              Colors.Header.gradient.withAlphaComponent(1.0).cgColor]
        // Set locations of where gradient will transition
        gradient.locations = [0.0,NSNumber(value: Constants.Header.gradientLocation)]
        // Add gradient as bottom layer in sublayer array
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    func resetNameHeight() {
        let frame = name.frameForLabel(text: name.text!, font: name.font!, numberOfLines: name.numberOfLines)
        Sizing.Header.nameHeight = frame.height
        nameHeight.constant      = frame.height
        layoutIfNeeded()
    }
    
    //MARK: Adjusting State
    func scaleDirectly(with scalar: CGFloat) {
        resetHeight(with: scalar)
        resetName(with: scalar)
        resetPhoto(with: scalar)
        resetGradient(with: scalar)
    }
    
    func scaleInversely(with scalar: CGFloat) {
        (scalar < 0.0) ? hideName(with: scalar) : nil
    }
    
    func resetHeight(with scalar: CGFloat) {
        let newHeight = (scalar > 1.0)
          ? Sizing.Header.expandedHeight
          : scalar * Sizing.Header.heightAdjustment + Sizing.Header.minimizedHeight
        height.constant = newHeight
    }
    
    func resetName(with scalar: CGFloat) {
        name.alpha = (name.textAlignment == .left) ? scalar : 1.0
        let newAlignment: NSTextAlignment = (scalar == 0.0) ? .center : .left
        let newFont: UIFont = ((scalar == 0.0) ? Fonts.Header.smallName : Fonts.Header.name)!
        if name.textAlignment != newAlignment {
            name.alpha = 0.0
            name.textAlignment = newAlignment
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: [.curveEaseInOut],
                animations: ({
                    self.name.alpha = 1.0
                    self.name.font = newFont
                }))
        }
    }
    
    func hideName(with scalar: CGFloat) {
        name.alpha = scalar+1.0
        nameBottom.constant = -Sizing.Header.nameBottom + -scalar*Sizing.Header.nameHeight
    }
    
    func resetPhoto(with scalar: CGFloat) {
        photo.alpha = scalar
    }
    
    func resetGradient(with scalar: CGFloat) {
        // Set origin of gradient (top left of screen)
        let scale = (scalar > 1.0) ? (scalar-1)/(Sizing.Scroll.limit/Sizing.width) : 0.0
        let gradientOrigin = CGPoint(x: 0, y: scale*Sizing.Header.nameHeight)
        // Set frame of gradient (header height, because status bar will be solid color)
        let gradientSize = CGSize(width: Sizing.width, height: Sizing.Header.expandedHeight)
        gradient.frame = CGRect(origin: gradientOrigin, size: gradientSize)
    }

    
}
