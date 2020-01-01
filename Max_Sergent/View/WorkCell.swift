//
//  WorkCell.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import UIKit

class WorkCell: UITableViewCell {

    // Constraints
    var positionHeight: NSLayoutConstraint!
    var workCompletedHeight: NSLayoutConstraint!
    var startDateHeight: NSLayoutConstraint!
    
    // Objects
    let icon = UIImageView()
    let position = UILabel()
    let startDate = UILabel()
    let workCompleted = UILabel()
    
    //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.Experience.cellReuseId)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    //MARK: Setup
    func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        objectSettings()
        constraints()
    }
    
    //MARK: Object Settings
    func objectSettings() {
        addSubview(icon)
        addSubview(position)
        position.textColor            = UI.Colors.Experience.cellText
        position.textAlignment        = .left
        position.font                 = UI.Fonts.Experience.cellHeader
        position.alpha                = 1.0
        position.numberOfLines = 0
        position.lineBreakMode = .byClipping

        addSubview(startDate)
        startDate.textColor     = UI.Colors.Experience.cellText
        startDate.textAlignment = .right
        startDate.font          = UI.Fonts.Experience.cellHeader
        startDate.alpha         = 1.0
        startDate.numberOfLines = 0
        startDate.lineBreakMode = .byClipping
        
        addSubview(workCompleted)
        workCompleted.textColor     = UI.Colors.Experience.cellText
        workCompleted.textAlignment = .left
        workCompleted.font          = UI.Fonts.Experience.cellBody
        workCompleted.alpha         = 1.0
        workCompleted.numberOfLines = 0
        workCompleted.lineBreakMode = .byClipping
    }
    
    //MARK: Constraints
    func constraints() {
        positionConstraints()
        startDateConstraints()
        workCompletedConstraints()
    }
    
}
