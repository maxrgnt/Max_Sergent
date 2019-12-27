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
    
    func menuConstraints() {
        menu.translatesAutoresizingMaskIntoConstraints                                                            = false
        menu.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        menu.topAnchor.constraint(equalTo: header.bottomAnchor).isActive                                          = true
        menu.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.width).isActive                             = true
        menu.heightAnchor.constraint(equalToConstant: UI.Sizing.Menu.height).isActive                           = true
    }
    
    func scrollConstraints() {
        scroll.translatesAutoresizingMaskIntoConstraints                                                            = false
        scroll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive                                  = true
        scroll.topAnchor.constraint(equalTo: menu.bottomAnchor).isActive                                          = true
        scroll.widthAnchor.constraint(equalToConstant: UI.Sizing.Scroll.width).isActive                             = true
        scroll.heightAnchor.constraint(equalToConstant: UI.Sizing.Scroll.height).isActive                           = true
    }
    
}

extension Header {
    
    func nameConstraints() {
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

extension Menu {
    
    func page1Constraints() {
        page1_width = page1.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        page2_width = page2.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        page3_width = page2.widthAnchor.constraint(equalToConstant: UI.Sizing.Menu.barWidth/4)
        
        page1.translatesAutoresizingMaskIntoConstraints                                                          = false
        page1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive                               = true
        page1.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page1_width.isActive                                                                                     = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                    = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                          = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                          = true
        page2.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page2_width.isActive                                                                                     = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                      = true
        
        page3.translatesAutoresizingMaskIntoConstraints                                                          = false
        page3.leadingAnchor.constraint(equalTo: page2.trailingAnchor).isActive                          = true
        page3.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                                  = true
        page3_width.isActive                                                                                     = true
        page3.heightAnchor.constraint(equalTo: heightAnchor).isActive                                      = true

    }
    
}

extension Scroll {
    
    func pageConstraints() {
        overview.translatesAutoresizingMaskIntoConstraints                                                          = false
        overview.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        overview.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        overview.widthAnchor.constraint(equalTo: widthAnchor).isActive                                              = true
        overview.heightAnchor.constraint(equalTo: heightAnchor).isActive                                            = true

        experience.translatesAutoresizingMaskIntoConstraints                                                        = false
        experience.leadingAnchor.constraint(equalTo: overview.trailingAnchor).isActive                              = true
        experience.topAnchor.constraint(equalTo: topAnchor).isActive                                                = true
        experience.widthAnchor.constraint(equalTo: widthAnchor).isActive                                            = true
        experience.heightAnchor.constraint(equalTo: heightAnchor).isActive                                          = true
        
        page1.translatesAutoresizingMaskIntoConstraints                                                             = false
        page1.leadingAnchor.constraint(equalTo: experience.trailingAnchor).isActive                                   = true
        page1.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page1.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page1.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
        page2.translatesAutoresizingMaskIntoConstraints                                                             = false
        page2.leadingAnchor.constraint(equalTo: page1.trailingAnchor).isActive                                      = true
        page2.topAnchor.constraint(equalTo: topAnchor).isActive                                                     = true
        page2.widthAnchor.constraint(equalTo: widthAnchor).isActive                                                 = true
        page2.heightAnchor.constraint(equalTo: heightAnchor).isActive                                               = true
        
    }
    
}

extension Overview {
    
    func objectiveConstraints() {
        objective.translatesAutoresizingMaskIntoConstraints                                                         = false
        objective.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                         = true
        objective.topAnchor.constraint(equalTo: topAnchor).isActive                                                 = true
        objective.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.objectiveWidth).isActive               = true
        objective.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.objectiveHeight).isActive             = true
    }
    
    func originDateConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        originDate.translatesAutoresizingMaskIntoConstraints                                                        = false
        originDate.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                        = true
        originDate.topAnchor.constraint(equalTo: objective.bottomAnchor, constant: topPadding).isActive             = true
        originDate.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.originDateWidth).isActive             = true
        originDate.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.originDateHeight).isActive           = true
    }
    
    func projectConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        let padding = UI.Sizing.Overview.padding
        
        personal_swiftWidth = personal_swiftBar.widthAnchor.constraint(equalToConstant: 5.0)
        personal_pythonWidth = personal_pythonBar.widthAnchor.constraint(equalToConstant: 0.0)
        personal_emptyWidth = personal_emptyBar.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth-5)
        
        personalProject.translatesAutoresizingMaskIntoConstraints                                                       = false
        personalProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                       = true
        personalProject.topAnchor.constraint(equalTo: originDate.bottomAnchor, constant: topPadding).isActive           = true
        personalProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive               = true
        personalProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive             = true
        
        personal_swiftBar.translatesAutoresizingMaskIntoConstraints                                                     = false
        personal_swiftBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive                  = true
        personal_swiftBar.topAnchor.constraint(equalTo: personalProject.bottomAnchor, constant: topPadding).isActive        = true
        personal_swiftWidth.isActive                                                                                    = true
        personal_swiftBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive               = true
        
        personal_pythonBar.translatesAutoresizingMaskIntoConstraints                                                    = false
        personal_pythonBar.leadingAnchor.constraint(equalTo: personal_swiftBar.trailingAnchor).isActive                     = true
        personal_pythonBar.topAnchor.constraint(equalTo: personalProject.bottomAnchor, constant: topPadding).isActive       = true
        personal_pythonWidth.isActive                                                                                   = true
        personal_pythonBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive              = true
        
        personal_emptyBar.translatesAutoresizingMaskIntoConstraints                                                     = false
        personal_emptyBar.leadingAnchor.constraint(equalTo: personal_pythonBar.trailingAnchor).isActive                     = true
        personal_emptyBar.topAnchor.constraint(equalTo: personalProject.bottomAnchor, constant: topPadding).isActive        = true
        personal_emptyWidth.isActive                                                                                    = true
        personal_emptyBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive               = true
        
        personalStats.translatesAutoresizingMaskIntoConstraints                                                         = false
        personalStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                         = true
        personalStats.topAnchor.constraint(equalTo: personal_swiftBar.bottomAnchor, constant: topPadding/2).isActive        = true
        personalStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                    = true
        personalStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                  = true
        
    }
    
    func workProjectConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        let padding = UI.Sizing.Overview.padding
        
        work_sqlWidth = work_sqlBar.widthAnchor.constraint(equalToConstant: 5.0)
        work_emptyWidth = work_emptyBar.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth-5)
        
        workProject.translatesAutoresizingMaskIntoConstraints                                                       = false
        workProject.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                       = true
        workProject.topAnchor.constraint(equalTo: personalStats.bottomAnchor, constant: topPadding).isActive            = true
        workProject.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectWidth).isActive               = true
        workProject.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.projectHeight).isActive             = true
        
        work_sqlBar.translatesAutoresizingMaskIntoConstraints                                                       = false
        work_sqlBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive                    = true
        work_sqlBar.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: topPadding).isActive          = true
        work_sqlWidth.isActive                                                                                      = true
        work_sqlBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive                 = true
        
        work_emptyBar.translatesAutoresizingMaskIntoConstraints                                                     = false
        work_emptyBar.leadingAnchor.constraint(equalTo: work_sqlBar.trailingAnchor).isActive                        = true
        work_emptyBar.topAnchor.constraint(equalTo: workProject.bottomAnchor, constant: topPadding).isActive        = true
        work_emptyWidth.isActive                                                                                    = true
        work_emptyBar.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.barHeight).isActive               = true

        workStats.translatesAutoresizingMaskIntoConstraints                                                         = false
        workStats.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                         = true
        workStats.topAnchor.constraint(equalTo: work_sqlBar.bottomAnchor, constant: topPadding/2).isActive          = true
        workStats.widthAnchor.constraint(equalToConstant: UI.Sizing.Overview.statWidth).isActive                    = true
        workStats.heightAnchor.constraint(equalToConstant: UI.Sizing.Overview.statHeight).isActive                  = true
        
    }
    
}

extension Experience {
    
    func headerConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        
        header.translatesAutoresizingMaskIntoConstraints                                                            = false
        header.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                            = true
        header.topAnchor.constraint(equalTo: topAnchor, constant: topPadding/2).isActive                            = true
        header.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                   = true
        header.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.headerHeight).isActive                 = true
    }
    
    func tableConstraints() {
        let topPadding = UI.Sizing.Overview.topPadding
        
        table.translatesAutoresizingMaskIntoConstraints                                                             = false
        table.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                             = true
        table.topAnchor.constraint(equalTo: header.bottomAnchor, constant: topPadding/2).isActive                   = true
        table.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                    = true
        table.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.tableHeight).isActive                   = true
    }
    
}

extension ExperienceSection {
    
    func companyConstraints() {
        company.translatesAutoresizingMaskIntoConstraints                                                          = false
        company.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        company.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                              = true
        company.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                 = true
        company.heightAnchor.constraint(equalTo: heightAnchor).isActive                                            = true
    }
    
}

extension ExperienceCell {
    
    func iconConstraints() {
        position.translatesAutoresizingMaskIntoConstraints                                                          = false
        position.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        position.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        position.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                 = true
        position.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.positionHeight).isActive             = true
    }
    
    func positionConstraints() {
        positionHeight = position.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.positionHeight)
        
        position.translatesAutoresizingMaskIntoConstraints                                                          = false
        position.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        position.topAnchor.constraint(equalTo: topAnchor).isActive                                                  = true
        position.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                 = true
        positionHeight.isActive                                                                                     = true
    }
    
    func accomplishmentsConstraints() {
        accomplishmentsHeight = accomplishments.heightAnchor.constraint(equalToConstant: UI.Sizing.Experience.accomplishmentsHeight)
        
        accomplishments.translatesAutoresizingMaskIntoConstraints                                                          = false
        accomplishments.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                                          = true
        accomplishments.topAnchor.constraint(equalTo: position.bottomAnchor).isActive                                      = true
        accomplishments.widthAnchor.constraint(equalToConstant: UI.Sizing.Experience.paddedWidth).isActive                 = true
        accomplishmentsHeight.isActive                                                                                     = true
    }
    
}
