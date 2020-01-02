//
//  WorkCell.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import UIKit

class SchoolCell: UITableViewCell {

    // Constraints
    var positionHeight: NSLayoutConstraint!
    var workCompletedHeight: NSLayoutConstraint!
    var startDateHeight: NSLayoutConstraint!
    
    // Objects
    let icon = UIImageView()
    let nameOfClass = UILabel()
    let startDate = UILabel()
    let stuffLearned = UILabel()
    
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
        addSubview(nameOfClass)
        nameOfClass.textColor            = UI.Colors.Experience.cellText
        nameOfClass.textAlignment        = .left
        nameOfClass.font                 = UI.Fonts.Experience.cellHeader
        nameOfClass.alpha                = 1.0
        nameOfClass.numberOfLines = 0
        nameOfClass.lineBreakMode = .byClipping

        addSubview(startDate)
        startDate.textColor     = UI.Colors.Experience.cellText
        startDate.textAlignment = .right
        startDate.font          = UI.Fonts.Experience.cellHeader
        startDate.alpha         = 1.0
        startDate.numberOfLines = 0
        startDate.lineBreakMode = .byClipping
        
        addSubview(stuffLearned)
        stuffLearned.textColor     = UI.Colors.Experience.cellText
        stuffLearned.textAlignment = .left
        stuffLearned.font          = UI.Fonts.Experience.cellBody
        stuffLearned.alpha         = 1.0
        stuffLearned.numberOfLines = 0
        stuffLearned.lineBreakMode = .byClipping
    }
    
    //MARK: Constraints
    func constraints() {
        nameOfClassConstraints()
        startDateConstraints()
        stuffLearnedConstraints()
    }
    
}
