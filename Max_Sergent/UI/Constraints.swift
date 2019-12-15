//
//  Constraints.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/9/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func headerConstraints() {
        header.translatesAutoresizingMaskIntoConstraints                                                          = false
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UI.Sizing.statusBar.height).isActive  = true
        header.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.width).isActive                         = true
        header.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.height).isActive                       = true
    }
    
}

extension Header {
    
    func nameConstraints() {
        let padding = UI.Sizing.Overview.padding
        
        picture.translatesAutoresizingMaskIntoConstraints                                                           = false
        picture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        picture.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive                                = true
        picture.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.pictureDiameter).isActive                = true
        picture.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.pictureDiameter).isActive               = true
        
        name.translatesAutoresizingMaskIntoConstraints                                                              = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        name.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: padding).isActive                        = true
        name.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.nameWidth).isActive                         = true
        name.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.nameHeight).isActive                       = true
    }
    
}
