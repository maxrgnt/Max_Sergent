//
//  Constraints_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/8/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

extension ViewController_NEW {
    
    func constraints() {
        headerConstraints()
        header.layoutIfNeeded()
        scrollConstraints()
        scroll.layoutIfNeeded()
        footerConstraints()
        footer.layoutIfNeeded()
    }
    
    func headerConstraints() {
        header.top = header.topAnchor.constraint(equalTo: self.view.topAnchor)
        header.height = header.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.expandedHeight)
        header.translatesAutoresizingMaskIntoConstraints                                                            = false
        header.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        header.top.isActive    = true
        header.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.width).isActive                             = true
        header.height.isActive                                                                                      = true
    }
    
    func scrollConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints                                                            = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        scroll.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                          = true
        scroll.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Scroll.width).isActive                             = true
        scroll.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Scroll.height).isActive                           = true
    }
    
    func footerConstraints() {
        footer.translatesAutoresizingMaskIntoConstraints                                                            = false
        footer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        footer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive    = true
        footer.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Footer.width).isActive                             = true
        footer.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Footer.height).isActive                   = true
    }
    
}

extension Header_NEW {
    
    func constraints() {
        nameHeight = name.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.expandedNameHeight)
        
        picture.translatesAutoresizingMaskIntoConstraints                                                           = false
        picture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        picture.topAnchor.constraint(equalTo: topAnchor).isActive     = true
        picture.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.width).isActive                         = true
        picture.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        name.translatesAutoresizingMaskIntoConstraints                                                              = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        name.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  = true
        name.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.nameWidth).isActive                           = true
        nameHeight.isActive                                                                                         = true
    }

}

extension Scroll_NEW {
    
    func constraints() {
        page1Constraints()
        page2Constraints()
        page3Constraints()
    }
    
    func page1Constraints() {
        page1.translatesAutoresizingMaskIntoConstraints                                                          = false
        page1.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        page1.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        page1.widthAnchor.constraint(equalTo: widthAnchor).isActive                                              = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                            = true
    }
    
    func page2Constraints() {
        page2.translatesAutoresizingMaskIntoConstraints                                                        = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                              = true
        page2.topAnchor.constraint(equalTo: topAnchor).isActive                                                = true
        page2.widthAnchor.constraint(equalTo: widthAnchor).isActive                                            = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                          = true
    }
    
    func page3Constraints() {
        page3.translatesAutoresizingMaskIntoConstraints                                                             = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                                      = true
        page3.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page3.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
    }
    
}

extension Footer_NEW {
    
    func constraints() {
        blurConstraints()
        vibrancyConstraints()
        menuConstraints()
    }
    
    func blurConstraints() {
        blur.translatesAutoresizingMaskIntoConstraints                                                              = false
        blur.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        blur.topAnchor.constraint(equalTo: topAnchor).isActive  = true
        blur.widthAnchor.constraint(equalTo: widthAnchor).isActive                           = true
        blur.heightAnchor.constraint(equalTo: heightAnchor).isActive               = true
    }
    
    func vibrancyConstraints() {
        vibrancy.translatesAutoresizingMaskIntoConstraints                                                              = false
        vibrancy.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        vibrancy.topAnchor.constraint(equalTo: topAnchor).isActive  = true
        vibrancy.widthAnchor.constraint(equalTo: widthAnchor).isActive                           = true
        vibrancy.heightAnchor.constraint(equalTo: heightAnchor).isActive               = true
    }
    
    func menuConstraints() {
        menu.translatesAutoresizingMaskIntoConstraints                                                              = false
        menu.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        menu.topAnchor.constraint(equalTo: topAnchor).isActive  = true
        menu.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.menuWidth).isActive                           = true
        menu.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.menuHeight).isActive               = true
    }
}

extension Menu_NEW {
    
    func constraints() {
        page1_width = page1.widthAnchor.constraint(equalToConstant: 0.0)
        page2_width = page2.widthAnchor.constraint(equalToConstant: 0.0)
        page3_width = page3.widthAnchor.constraint(equalToConstant: 0.0)
        
        page1_height = page1.heightAnchor.constraint(equalToConstant: 0.0)
        page2_height = page2.heightAnchor.constraint(equalToConstant: 0.0)
        page3_height = page3.heightAnchor.constraint(equalToConstant: 0.0)
        
        page1.translatesAutoresizingMaskIntoConstraints                                                          = false
        page1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive           = true
        page1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                          = true
        page1_width.isActive                                                                                     = true
        page1_height.isActive                                    = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                          = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                          = true
        page2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page2_width.isActive                                                                                     = true
        page2_height.isActive                                      = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                          = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                          = true
        page3.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page3_width.isActive                                                                                     = true
        page3_height.isActive                                      = true

    }
    
}
