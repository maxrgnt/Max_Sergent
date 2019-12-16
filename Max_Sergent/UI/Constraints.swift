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
        header.height = header.heightAnchor.constraint(equalToConstant: UI.Sizing.Header.expandedHeight)
        header.translatesAutoresizingMaskIntoConstraints                                                            = false
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UI.Sizing.statusBar.height).isActive    = true
        header.widthAnchor.constraint(equalToConstant: UI.Sizing.Header.width).isActive                             = true
        header.height.isActive                                                                                      = true
    }
    
    func scrollConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints                                                            = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        scroll.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                          = true
        scroll.widthAnchor.constraint(equalToConstant: UI.Sizing.Scroll.width).isActive                             = true
        scroll.heightAnchor.constraint(equalToConstant: UI.Sizing.Scroll.height).isActive                           = true
    }
    
}

extension Header {
    
    func nameConstraints() {
        let padding = UI.Sizing.Header.padding
        pictureWidth = picture.widthAnchor.constraint(equalToConstant: UI.Sizing.Header.pictureDiameter)
        pictureHeight = picture.heightAnchor.constraint(equalToConstant: UI.Sizing.Header.pictureDiameter)
        nameHeight = name.heightAnchor.constraint(equalToConstant: UI.Sizing.Header.expandedNameHeight)
        
        picture.translatesAutoresizingMaskIntoConstraints                                                           = false
        picture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        picture.topAnchor.constraint(equalTo: topAnchor, constant: UI.Sizing.Header.pictureTopPadding).isActive     = true
        pictureWidth.isActive                                                                                       = true
        pictureHeight.isActive                                                                                      = true
        
        name.translatesAutoresizingMaskIntoConstraints                                                              = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UI.Sizing.Header.nameBottomPadding).isActive  = true
        name.widthAnchor.constraint(equalToConstant: UI.Sizing.Header.nameWidth).isActive                           = true
        nameHeight.isActive                                                                                         = true
    }
    
}

extension Scroll {
    
    func pageConstraints() {
        page1.translatesAutoresizingMaskIntoConstraints                                                             = false
        page1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                             = true
        page1.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page1.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                             = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                                      = true
        page2.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page2.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                             = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                                      = true
        page3.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page3.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
    }
    
}
