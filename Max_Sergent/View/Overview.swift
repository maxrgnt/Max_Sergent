//
//  Overview.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/16/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Overview: UIView {
    
    //MARK: Definitions
    // Objects
    let objective = UILabel()
    let selfProject = UILabel()
    let swiftDays = UIView()
    let pythonDays = UIView()
    let emptySelf = UIView()
    let workProject = UILabel()
    let sqlDays = UIView()
    let emptyWork = UIView()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UI.Colors.Overview.background
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        addSubview(objective)
        objective.numberOfLines = 7
        objective.textAlignment = .left
        //objective.backgroundColor = .gray
        objective.minimumScaleFactor = 0.1
        objective.lineBreakMode = .byClipping
        objective.adjustsFontSizeToFitWidth = true
        objective.font = UI.Fonts.Overview.objective
        objective.text = Constants.Overview.objective
        objective.textColor = UI.Colors.Overview.objective
        
        let text = [Constants.Overview.selfProject, Constants.Overview.workProject]
        for (i, project) in [selfProject,workProject].enumerated() {
            addSubview(project)
            project.numberOfLines = 2
            project.textAlignment = .left
            //objective.backgroundColor = .gray
            project.minimumScaleFactor = 0.1
            project.lineBreakMode = .byClipping
            project.adjustsFontSizeToFitWidth = true
            project.font = UI.Fonts.Overview.project
            project.text = text[i]
            project.textColor = UI.Colors.Overview.project
        }
        
        let colors: [UIColor] = [.red, .yellow, .black, .blue, .black]
        for (i, bar) in [swiftDays, pythonDays, emptySelf, sqlDays, emptyWork].enumerated() {
            addSubview(bar)
            bar.backgroundColor = colors[i]
        }
        swiftDays.roundCorners(corners: [.topLeft,.bottomLeft], radius: UI.Sizing.Overview.barHeight/2)
        emptySelf.roundCorners(corners: [.topRight,.bottomRight], radius: UI.Sizing.Overview.barHeight/2)
        sqlDays.roundCorners(corners: [.topLeft,.bottomLeft], radius: UI.Sizing.Overview.barHeight/2)
        emptyWork.roundCorners(corners: [.topRight,.bottomRight], radius: UI.Sizing.Overview.barHeight/2)
    }
    
    func constraints() {
        objectiveConstraints()
        projectConstraints()
        workProjectConstraints()
    }
    
}
