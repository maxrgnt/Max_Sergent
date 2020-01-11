//
//  Header_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/8/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Header_NEW: UIView {
    
    //MARK: Definitions
    // Constraints
    var height:        NSLayoutConstraint!
    var top:           NSLayoutConstraint!
    var pictureHeight: NSLayoutConstraint!
    var nameHeight:    NSLayoutConstraint!
    var nameBottom:    NSLayoutConstraint!
    // Objects
    let picture = UIImageView()
    let name = UILabel()
    let gradient = CAGradientLayer()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        backgroundColor = UI_NEW.Colors.Header.background
        
        addSubview(picture)
        picture.image = UIImage(named: "profile.jpg")
        picture.clipsToBounds = true
        picture.layer.masksToBounds = true
        picture.contentMode = .scaleAspectFill // .scaleToFill - .center - .scaleAspectFit
        //picture.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: UI.Sizing.Header.pictureRadius)
                
        buildGradient()
        
        addSubview(name)
        name.numberOfLines = 2
        name.textAlignment = .left
        name.backgroundColor = .clear
        name.minimumScaleFactor = 0.1
        name.lineBreakMode = .byClipping
        name.adjustsFontSizeToFitWidth = true
        name.font = UI_NEW.Fonts.Header.name
        name.text = Constants_NEW.Header.name
        name.textColor = UI_NEW.Colors.Header.name
    }
    
    func buildGradient() {
        // Set origin of gradient (top left of screen)
        let gradientOrigin = CGPoint(x: 0, y: 0.0)
        // Set frame of gradient (header height, because status bar will be solid color)
        let gradientSize = CGSize(width: UI_NEW.Sizing.Header.width, height: UI_NEW.Sizing.Header.expandedHeight)
        gradient.frame = CGRect(origin: gradientOrigin, size: gradientSize)
        // Set color progression for gradient, alphaComponent of zero important for color shifting to
        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                           UIColor.black.withAlphaComponent(1.0).cgColor]
        // Set locations of where gradient will transition
        gradient.locations = [0.0,NSNumber(value: Constants_NEW.Header.gradient)]
        // Add gradient as bottom layer in sublayer array
        self.layer.insertSublayer(gradient, at: 1)
    }
    
    func scaleDirectly(with scalar: CGFloat) {
        resetHeight(with: scalar)
        resetName(with: scalar)
        resetPicture(with: scalar)
        resetGradient(with: scalar)
    }
    
    func scaleInversely(with scalar: CGFloat) {
        (scalar < 0.0) ? hideName(with: scalar) : nil
    }
    
    func resetView(with scaleHeaderHeight: CGFloat) {
        // Move to a background thread to do some long running work
        DispatchQueue.global(qos: .userInitiated).async {
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.resetHeight(with: scaleHeaderHeight)
                self.resetPicture(with: scaleHeaderHeight)
                self.resetName(with: scaleHeaderHeight)
            }
        }
    }
    
    func resetHeight(with scalar: CGFloat) {
        let newHeight = (scalar > 1.0)
          ? UI_NEW.Sizing.Header.expandedHeight
          : scalar * UI_NEW.Sizing.Header.heightDiff + UI_NEW.Sizing.Header.minimizedHeight
        height.constant = newHeight
    }
    
    func resetName(with scalar: CGFloat) {
        var adjFontHeight = scalar*UI_NEW.Sizing.Header.nameDiff + UI_NEW.Sizing.Header.minimizedNameHeight
        adjFontHeight = (adjFontHeight >= UI_NEW.Sizing.Header.expandedNameHeight)
            ? UI_NEW.Sizing.Header.expandedNameHeight
            : adjFontHeight
        nameHeight.constant = adjFontHeight
        name.sizeToFit()
        
        name.alpha = (name.textAlignment == .left) ? scalar : 1.0
        let newAlignment: NSTextAlignment = (scalar == 0.0) ? .center : .left
        if name.textAlignment != newAlignment {
            name.alpha = 0.0
            name.textAlignment = newAlignment
            UIView.animate(withDuration: 0.3,
                           delay: 0.0,
                           options: [.curveEaseInOut],
                animations: ({
                    self.name.alpha = 1.0
                }))
        }
    }
    
    func hideName(with scalar: CGFloat) {
        name.alpha = scalar+1.0
        nameBottom.constant = UI_NEW.Sizing.Header.nameBottom + -scalar*UI_NEW.Sizing.width*(0.8)
    }
    
    func resetPicture(with scalar: CGFloat) {
        picture.alpha = scalar
    }
    
    func resetGradient(with scalar: CGFloat) {
        // Set origin of gradient (top left of screen)
        let scale = (scalar > 1.0) ? scalar-1 : 0.0
        let gradientOrigin = CGPoint(x: 0, y: (scale)*UI_NEW.Sizing.Header.minimizedHeight)
        // Set frame of gradient (header height, because status bar will be solid color)
        let gradientSize = CGSize(width: UI_NEW.Sizing.Header.width, height: UI_NEW.Sizing.Header.expandedHeight)
        gradient.frame = CGRect(origin: gradientOrigin, size: gradientSize)
    }
    
}
