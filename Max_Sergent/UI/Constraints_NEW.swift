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
        nameBottom = name.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UI_NEW.Sizing.Header.nameBottom)
        
        picture.translatesAutoresizingMaskIntoConstraints                                                           = false
        picture.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        picture.topAnchor.constraint(equalTo: topAnchor).isActive     = true
        picture.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Header.width).isActive                         = true
        picture.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        name.translatesAutoresizingMaskIntoConstraints                                                              = false
        name.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        nameBottom.isActive  = true
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
        page1.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Overview.height).isActive                   = true
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

extension Overview_NEW {
    
    func constraints() {
        objectiveConstraints()
        contactBarConstraints()
//        statsConstraints()
    }
    
    func objectiveConstraints() {
        objectiveHeight = objective.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Overview.objectiveHeight)
        
        objective.translatesAutoresizingMaskIntoConstraints  = false
        objective.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        objective.topAnchor.constraint(equalTo: contactBar.bottomAnchor, constant: UI_NEW.Sizing.padding/2).isActive     = true
        objective.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Overview.objectiveWidth).isActive              = true
        objectiveHeight.isActive            = true
    }
    
    func contactBarConstraints() {
        contactBar.translatesAutoresizingMaskIntoConstraints  = false
        contactBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
        contactBar.topAnchor.constraint(equalTo: topAnchor, constant: UI_NEW.Sizing.padding/2).isActive     = true
        contactBar.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.Overview.contactBarWidth).isActive              = true
        contactBar.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.Overview.contactBarHeight).isActive            = true
    }
    
//    func statsConstraints() {
//        stats.translatesAutoresizingMaskIntoConstraints  = false
//        stats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                           = true
//        stats.topAnchor.constraint(equalTo: contactBar.bottomAnchor).isActive     = true
//        stats.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.width).isActive              = true
//        stats.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.height).isActive            = true
//    }
    
}

extension ContactBar {
    
    func constraints() {
        iconConstraints()
        textConstraints()
    }
    
    func iconConstraints() {
        emailIcon.translatesAutoresizingMaskIntoConstraints                                                              = false
        emailIcon.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                              = true
        emailIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  = true
        emailIcon.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.iconDiameter).isActive           = true
        emailIcon.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.iconDiameter).isActive               = true
        
        locationIcon.translatesAutoresizingMaskIntoConstraints                                                         = false
        locationIcon.leadingAnchor.constraint(equalTo: emailText.trailingAnchor).isActive                               = true
        locationIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  = true
        locationIcon.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.iconDiameter).isActive           = true
        locationIcon.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.iconDiameter).isActive               = true
    }
    
    func textConstraints() {
        let padding = UI_NEW.Sizing.ContactBar.padding
        
        emailText.translatesAutoresizingMaskIntoConstraints                                                              = false
        emailText.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: padding).isActive  = true
        emailText.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  = true
        emailText.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.textWidth).isActive           = true
        emailText.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.iconDiameter).isActive               = true
        
        locationText.translatesAutoresizingMaskIntoConstraints                                                              = false
        locationText.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: padding).isActive  = true
        locationText.centerYAnchor.constraint(equalTo: centerYAnchor).isActive  = true
        locationText.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.textWidth).isActive           = true
        locationText.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.ContactBar.iconDiameter).isActive               = true
    }
    
}

extension OverviewStats {
    
    func constraints() {
        headerConstraints()
        trackConstraints()
    }
    
    func headerConstraints() {
        header.translatesAutoresizingMaskIntoConstraints                                                              = false
        header.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                              = true
        header.topAnchor.constraint(equalTo: topAnchor).isActive  = true
        header.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.headerHeight).isActive           = true
        header.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.headerWidth).isActive               = true
    }
    
    func trackConstraints() {
        track1.translatesAutoresizingMaskIntoConstraints                                                              = false
        track1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                                              = true
        track1.topAnchor.constraint(equalTo: header.bottomAnchor, constant: UI_NEW.Sizing.padding).isActive  = true
        track1.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackHeight).isActive           = true
        track1.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackWidth).isActive               = true
        
        track2.translatesAutoresizingMaskIntoConstraints                                                              = false
        track2.leadingAnchor.constraint(equalTo: track1.trailingAnchor, constant: UI_NEW.Sizing.padding).isActive        = true
        track2.topAnchor.constraint(equalTo: header.bottomAnchor, constant: UI_NEW.Sizing.padding).isActive  = true
        track2.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackHeight).isActive           = true
        track2.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackWidth).isActive               = true
        
        track3.translatesAutoresizingMaskIntoConstraints                                                              = false
        track3.leadingAnchor.constraint(equalTo: track2.trailingAnchor, constant: UI_NEW.Sizing.padding).isActive        = true
        track3.topAnchor.constraint(equalTo: header.bottomAnchor, constant: UI_NEW.Sizing.padding).isActive  = true
        track3.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackHeight).isActive           = true
        track3.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackWidth).isActive               = true
        
        track4.translatesAutoresizingMaskIntoConstraints                                                              = false
        track4.leadingAnchor.constraint(equalTo: track3.trailingAnchor, constant: UI_NEW.Sizing.padding).isActive        = true
        track4.topAnchor.constraint(equalTo: header.bottomAnchor, constant: UI_NEW.Sizing.padding).isActive  = true
        track4.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackHeight).isActive           = true
        track4.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewStats.trackWidth).isActive               = true
    }
    
}

extension OverviewTrack {
    
    func constraints() {
        dayConstraints()
    }
    
    func dayConstraints() {
        dayStatTop = dayStat.topAnchor.constraint(equalTo: topAnchor, constant: 0.0)
        dayUnitTop = dayUnit.topAnchor.constraint(equalTo: dayStat.bottomAnchor, constant: 0.0)
        dayStatHeight = dayStat.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewTrack.radius)
        dayUnitHeight = dayUnit.heightAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewTrack.radius)
            
        dayStat.translatesAutoresizingMaskIntoConstraints                                                              = false
        dayStat.centerXAnchor.constraint(equalTo: centerXAnchor).isActive        = true
        dayStatTop.isActive        = true
        dayStatHeight.isActive           = true
        dayStat.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewTrack.radius).isActive           = true
        
        dayUnit.translatesAutoresizingMaskIntoConstraints                                                              = false
        dayUnit.centerXAnchor.constraint(equalTo: centerXAnchor).isActive        = true
        dayUnitTop.isActive        = true
        dayUnitHeight.isActive           = true
        dayUnit.widthAnchor.constraint(equalToConstant: UI_NEW.Sizing.OverviewTrack.radius).isActive           = true
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
