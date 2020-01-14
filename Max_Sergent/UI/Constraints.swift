//
//  Constraints.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

//MARK: ViewController
extension ViewController {
    
    func constraints() {
        header.height = header.heightAnchor.constraint(equalToConstant: Sizing.Header.expandedHeight)
        header.translatesAutoresizingMaskIntoConstraints                                                                = false
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                      = true
        header.topAnchor.constraint(equalTo: self.view.topAnchor).isActive                                              = true
        header.widthAnchor.constraint(equalToConstant: Sizing.width).isActive                                           = true
        header.height.isActive                                                                                          = true
        
        scroll.translatesAutoresizingMaskIntoConstraints                                                                = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                      = true
        scroll.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                              = true
        scroll.widthAnchor.constraint(equalToConstant: Sizing.width).isActive                                           = true
        scroll.heightAnchor.constraint(equalToConstant: Sizing.Scroll.height).isActive                                  = true
        
        footer.translatesAutoresizingMaskIntoConstraints                                                                = false
        footer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                      = true
        footer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -Sizing.padding).isActive             = true
        footer.widthAnchor.constraint(equalToConstant: Sizing.paddedWidth).isActive                                     = true
        footer.heightAnchor.constraint(equalToConstant: Sizing.Footer.height).isActive                                  = true
    }
    
}

//MARK: Header
extension Header {
    
    func constraints() {
        nameHeight = name.heightAnchor.constraint(equalToConstant: Sizing.Header.nameHeight)
        nameBottom = name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizing.Header.nameBottom)
        name.translatesAutoresizingMaskIntoConstraints                                                                  = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        nameBottom.isActive                                                                                             = true
        name.widthAnchor.constraint(equalToConstant: Sizing.paddedWidth).isActive                                       = true
        nameHeight.isActive                                                                                             = true
        
        photo.translatesAutoresizingMaskIntoConstraints                                                                 = false
        photo.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        photo.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                                 = true
        photo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive                                                   = true
        photo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive                                               = true
    }
    
}

//MARK: Scroll
extension Scroll {
    
    func constraints() {
        page1.translatesAutoresizingMaskIntoConstraints                                                                 = false
        page1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                 = true
        page1.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        page1.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                     = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                   = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                                 = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                                          = true
        page2.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        page2.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                     = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                   = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                                 = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                                          = true
        page3.topAnchor.constraint(equalTo: topAnchor).isActive                                                         = true
        page3.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                     = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                   = true
    }
    
}

//MARK: Overview
extension Overview {
    
    func constraints() {
        let verticalPadding = Sizing.Header.nameBottom/2
        
        title1Height = title1.heightAnchor.constraint(equalToConstant: 0.0)
        title1.translatesAutoresizingMaskIntoConstraints                                                                = false
        title1.centerXAnchor.constraint(equalTo: box1.centerXAnchor).isActive                                           = true
        title1.topAnchor.constraint(equalTo: topAnchor, constant: verticalPadding*2).isActive                           = true
        title1.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxPaddedWidth).isActive                         = true
        title1Height.isActive                                                                                           = true
        
        box1Height = box1.heightAnchor.constraint(equalToConstant: Sizing.Overview.box1Height)
        box1.translatesAutoresizingMaskIntoConstraints                                                                  = false
        box1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        box1.topAnchor.constraint(equalTo: title1.bottomAnchor, constant: verticalPadding).isActive                     = true
        box1.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxWidth).isActive                                 = true
        box1Height.isActive                                                                                             = true
        
        objectiveHeight = objective.heightAnchor.constraint(equalToConstant: Sizing.Overview.objectiveHeight)
        objective.translatesAutoresizingMaskIntoConstraints                                                             = false
        objective.centerXAnchor.constraint(equalTo: box1.centerXAnchor).isActive                                        = true
        objective.centerYAnchor.constraint(equalTo: box1.centerYAnchor).isActive                                        = true
        objective.widthAnchor.constraint(equalToConstant: Sizing.Overview.boxPaddedWidth).isActive                      = true
        objectiveHeight.isActive                                                                                        = true
    }
    
}

//MARK: Footer
extension Footer {
    
    func constraints() {
        blur.translatesAutoresizingMaskIntoConstraints                                                                  = false
        blur.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        blur.topAnchor.constraint(equalTo: topAnchor).isActive                                                          = true
        blur.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                      = true
        blur.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                    = true
        
        vibrancy.translatesAutoresizingMaskIntoConstraints                                                              = false
        vibrancy.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        vibrancy.topAnchor.constraint(equalTo: topAnchor).isActive                                                      = true
        vibrancy.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                  = true
        vibrancy.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                = true
        
        menu.translatesAutoresizingMaskIntoConstraints                                                                  = false
        menu.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                  = true
        menu.topAnchor.constraint(equalTo: topAnchor).isActive                                                          = true
        menu.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                      = true
        menu.heightAnchor.constraint(equalTo: heightAnchor).isActive                                                    = true
    }
    
}

//MARK: Menu
extension Menu {
    
    func constraints() {
        icon1.translatesAutoresizingMaskIntoConstraints                                                                 = false
        icon1.centerXAnchor.constraint(equalTo: label1.centerXAnchor).isActive                                           = true
        icon1.topAnchor.constraint(equalTo: topAnchor, constant: Sizing.padding/2).isActive                             = true
        icon1.widthAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                                = true
        icon1.heightAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                               = true
        
        label1.translatesAutoresizingMaskIntoConstraints                                                                 = false
        label1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizing.padding/2).isActive                     = true
        label1.topAnchor.constraint(equalTo: icon1.bottomAnchor).isActive                                                = true
        label1.widthAnchor.constraint(equalToConstant: Sizing.Menu.textWidth).isActive                                   = true
        label1.heightAnchor.constraint(equalToConstant: Sizing.Menu.textHeight).isActive                                 = true
        
        icon2.translatesAutoresizingMaskIntoConstraints                                                                 = false
        icon2.centerXAnchor.constraint(equalTo: label2.centerXAnchor).isActive                                           = true
        icon2.topAnchor.constraint(equalTo: topAnchor, constant: Sizing.padding/2).isActive                             = true
        icon2.widthAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                                = true
        icon2.heightAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                               = true
        
        label2.translatesAutoresizingMaskIntoConstraints                                                                 = false
        label2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                                 = true
        label2.topAnchor.constraint(equalTo: icon2.bottomAnchor).isActive                                                = true
        label2.widthAnchor.constraint(equalToConstant: Sizing.Menu.textWidth).isActive                                   = true
        label2.heightAnchor.constraint(equalToConstant: Sizing.Menu.textHeight).isActive                                 = true
        
        icon3.translatesAutoresizingMaskIntoConstraints                                                                 = false
        icon3.centerXAnchor.constraint(equalTo: label3.centerXAnchor).isActive                                           = true
        icon3.topAnchor.constraint(equalTo: topAnchor, constant: Sizing.padding/2).isActive                             = true
        icon3.widthAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                                = true
        icon3.heightAnchor.constraint(equalToConstant: Sizing.Menu.iconDiameter).isActive                               = true
    
        label3.translatesAutoresizingMaskIntoConstraints                                                                 = false
        label3.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizing.padding/2).isActive                  = true
        label3.topAnchor.constraint(equalTo: icon3.bottomAnchor).isActive                                                = true
        label3.widthAnchor.constraint(equalToConstant: Sizing.Menu.textWidth).isActive                                   = true
        label3.heightAnchor.constraint(equalToConstant: Sizing.Menu.textHeight).isActive                                 = true
    }
    
}
