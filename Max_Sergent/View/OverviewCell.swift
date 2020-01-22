//
//  OverviewCell.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/14/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {

    //MARK: Definitions
    // Delegates
    // Constraints
    var boxTop:         NSLayoutConstraint!
    var boxHeight:      NSLayoutConstraint!
    var iconHeight:     NSLayoutConstraint!
    var iconWidth:      NSLayoutConstraint!
    var contentHeight:  NSLayoutConstraint!
    var contentLeading: NSLayoutConstraint!
    // Objects
    var box     = UIView()
    var icon    = UIImageView()
    var content = UILabel()

    // Variables
    var includeIcon = false
    
    //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.Overview.cellReuseId)
        setup() {
            constraints()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
        
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(box)
        box.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Overview.boxRadius)
        
        box.addSubview(icon)
        icon.clipsToBounds       = true
        icon.layer.masksToBounds = true
        icon.contentMode         = .scaleAspectFill
        
        box.addSubview(content)
        content.numberOfLines   = 0
        content.textAlignment   = .left
        content.backgroundColor = .clear
        content.lineBreakMode   = .byWordWrapping
        content.font            = Fonts.Overview.content
        
        closure()
    }
    
    func calcHeights() -> CGFloat {
        let labelText =  (content.text ?? Constants.placeholder)!
        let contentFrame = content.frameForLabel(text: labelText,
                                                 font: content.font!,
                                                 numberOfLines: content.numberOfLines,
                                                 width: Sizing.Overview.boxPaddedWidth)
        return contentFrame.height
    }
    
    func resize(forIndex index: Int) {
        let calcHeight = calcHeights()
        boxTop.constant         = (index == 0) ? Sizing.Overview.padding/2 : 0.0
        contentHeight.constant  = calcHeight
        iconHeight.constant     = calcHeight
        iconWidth.constant      = (includeIcon) ? calcHeight : 0.0
        contentLeading.constant = (includeIcon) ? Sizing.Overview.padding/2 : 0.0
        boxHeight.constant      = calcHeight + Sizing.Overview.padding
        layoutIfNeeded()
    }
    
    func setIcon(withName name: String) {
        includeIcon = (name == "") ? false : true
        icon.image = (includeIcon) ? UIImage(named: name) : nil
    }

}
