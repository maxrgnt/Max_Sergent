//
//  ExperienceCell.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/23/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import UIKit

class ExperienceCell: UITableViewCell {

    // Objects
    let icon = UIImageView()
    let position = UILabel()
    let accomplishments = UILabel()
    
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
        position.font                 = UI.Fonts.Experience.cellBody
        position.alpha                = 1.0
        addSubview(accomplishments)
        accomplishments.textColor     = UI.Colors.Experience.cellText
        accomplishments.textAlignment = .left
        accomplishments.font          = UI.Fonts.Experience.cellBody
        accomplishments.alpha         = 1.0
        
    }
    
    //MARK: Constraints
    func constraints() {
        iconConstraints()
        positionConstraints()
        accomplishmentsConstraints()
    }
    
}
