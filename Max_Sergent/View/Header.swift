//
//  Header.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/9/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Header: UIView {
    
    //MARK: Definitions
    // Constraints
    var height:        NSLayoutConstraint!
    var pictureHeight: NSLayoutConstraint!
    var pictureWidth:  NSLayoutConstraint!
    var nameHeight:    NSLayoutConstraint!
    // Objects
    let picture = UIImageView()
    let name = UILabel()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UI.Colors.Header.background
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        addSubview(name)
        name.numberOfLines = 2
        name.textAlignment = .left
        name.backgroundColor = .clear
        name.minimumScaleFactor = 0.1
        name.lineBreakMode = .byClipping
        name.adjustsFontSizeToFitWidth = true
        name.font = UI.Fonts.Header.name
        name.text = Constants.Header.name
        name.textColor = UI.Colors.Header.name
        
        addSubview(picture)
        //picture.contentMode = .scaleAspectFit
        picture.image = UIImage(named: "placeholder.jpg")
        picture.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: UI.Sizing.Header.pictureRadius)
    }
    
    func constraints() {
        nameConstraints()
    }
    
}
