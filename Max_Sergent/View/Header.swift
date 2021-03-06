//
//  Header.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol HeaderDelegate {
    func calculateRatio(for: CGFloat)
}

class Header: UIView {
    
    //MARK: Definitions
    // Delegates
    var customDelegate: HeaderDelegate!
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
        backgroundColor = .clear
        clipsToBounds   = true
        
        roundCorners(corners: [.bottomLeft,.bottomRight], radius: Sizing.Header.boxRadius)
        
        addSubview(photo)
        photo.clipsToBounds       = true
        photo.layer.masksToBounds = true
        photo.contentMode         = .scaleAspectFill
        
        buildGradient()
        
        addSubview(name)
        name.numberOfLines             = 2
        name.textAlignment             = .left
        name.backgroundColor           = .clear
        name.lineBreakMode             = .byClipping
        //name.minimumScaleFactor        = 0.1
        //name.adjustsFontSizeToFitWidth = true
        name.font                      = Fonts.Header.name
        
        let daniela = UIPanGestureRecognizer(target: self, action: #selector(reactToPanGesture(_:)))
        addGestureRecognizer(daniela)
        
        closure()
    }
    
    func buildGradient() {
        // Set origin of gradient (top left of screen)
        let gradientOrigin = CGPoint(x: 0, y: 0.0)
        // Set frame of gradient (header height, because status bar will be solid color)
        let gradientSize   = CGSize(width: Sizing.width, height: Sizing.Header.expandedHeight + 10.0)
        gradient.frame     = CGRect(origin: gradientOrigin, size: gradientSize)
        // Set color progression for gradient, alphaComponent of zero important for color shifting to
        // done in reset Colors in ViewController
        // Set locations of where gradient will transition
        gradient.locations = [Constants.Header.gradientStart,
                              Constants.Header.gradientEnd]
        // Add gradient as bottom layer in sublayer array
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    func resetNameHeight() {
        let labelText =  (name.text ?? Constants.placeholder)!
        let frame = name.frameForLabel(text: labelText, font: name.font!, numberOfLines: name.numberOfLines)
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
        (scalar <= 0.0) ? hideName(with: scalar) : nil
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

    @objc func reactToPanGesture(_ sender: UIPanGestureRecognizer) {
        // Move view up/down
        let translation = sender.translation(in: self)
        let offset = (translation.y > Sizing.Scroll.limit) ? Sizing.Scroll.limit : translation.y
        offset > 0.0 ? self.customDelegate.calculateRatio(for: -offset) : nil
        if sender.state == UIGestureRecognizer.State.ended {
            self.customDelegate.calculateRatio(for: 0.0)
        }
    }
    
}
