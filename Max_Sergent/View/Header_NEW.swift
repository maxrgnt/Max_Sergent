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
    var pictureHeight: NSLayoutConstraint!
    var nameHeight:    NSLayoutConstraint!
    // Objects
    let picture = UIImageView()
    let name = UILabel()
    let gradient = CAGradientLayer()
    let menu = Menu_NEW()
    
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
        
        addSubview(picture)
        picture.image = UIImage(named: "profile.jpg")
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
        
        addSubview(menu)
        menu.setup()
    }
    
    func buildGradient() {
        // Set origin of gradient (top left of screen)
        let gradientOrigin = CGPoint(x: 0, y: UI_NEW.Sizing.statusBar.height)
        // Set frame of gradient (header height, because status bar will be solid color)
        let gradientSize = CGSize(width: UI_NEW.Sizing.Header.width, height: UI_NEW.Sizing.Header.expandedHeight)
        gradient.frame = CGRect(origin: gradientOrigin, size: gradientSize)
        // Set color progression for gradient, alphaComponent of zero important for color shifting to
        gradient.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                           UIColor.black.withAlphaComponent(1.0).cgColor]
        // Set locations of where gradient will transition
        gradient.locations = [0.0,0.65]
        // Add gradient as bottom layer in sublayer array
        self.layer.insertSublayer(gradient, at: 1)
    }
    
}
