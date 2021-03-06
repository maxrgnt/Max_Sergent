//
//  TimelineCell.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/15/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {

    //MARK: Definitions
    // Delegates
    // Constraints
    var boxTop:         NSLayoutConstraint!
    var boxHeight:      NSLayoutConstraint!
    var boxHeaderHeight: NSLayoutConstraint!
    var iconHeight:     NSLayoutConstraint!
    var iconWidth:      NSLayoutConstraint!
    var headerHeight:   NSLayoutConstraint!
    var distinctionWidth: NSLayoutConstraint!
    var contentHeight:  NSLayoutConstraint!
    var contentLeading: NSLayoutConstraint!
    // Objects
    var line    = UILabel()
    var box     = UIView()
    var boxHeader = UILabel()
    var icon    = UIImageView()
    var header  = UILabel()
    var distinction = UILabel()
    var content = UILabel()
    // Variables
    var includeIcon = false
    
    //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: Constants.Timeline.cellReuseId)
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
        
        addSubview(line)
        addSubview(boxHeader)
        boxHeader.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Timeline.boxRadius)
        
        addSubview(box)
        box.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Timeline.boxRadius)
        
        box.addSubview(icon)
        icon.clipsToBounds       = true
        icon.layer.masksToBounds = true
        icon.contentMode         = .scaleAspectFill
        
        addSubview(header)
        header.numberOfLines   = 1
        header.textAlignment   = .left
        header.backgroundColor = .clear
        header.font            = Fonts.Timeline.boxHeader
        
        addSubview(distinction)
        distinction.numberOfLines   = 1
        distinction.textAlignment   = .center
        distinction.font            = Fonts.Timeline.boxDistinction
        
        box.addSubview(content)
        content.numberOfLines   = 0
        content.textAlignment   = .left
        content.backgroundColor = .clear
        content.lineBreakMode   = .byWordWrapping
        content.font            = Fonts.Timeline.boxContent
        
        closure()
    }
    
    func calcDistinctionWidth() {
        let labelText =  (distinction.text ?? Constants.placeholder)!
        let distinctionFrame = distinction.frameForLabel(text: labelText,
                                                         font: distinction.font!,
                                                         numberOfLines: 1)
        distinctionWidth.constant = distinctionFrame.width + Sizing.Timeline.padding/2
        let radius = 0.188 * min(distinctionFrame.width, distinctionFrame.height)
        distinction.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: radius)
    }
    
    func resize(forIndex index: Int) {
        calcDistinctionWidth()
        var labelText =  (header.text ?? Constants.placeholder)!
        let heightForHeader = Fonts.calculateLabelHeight(for: labelText,
                                                        withFont: Fonts.Timeline.boxHeader!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 1)
        labelText =  (content.text ?? Constants.placeholder)!
        let heightForContent = Fonts.calculateLabelHeight(for: labelText,
                                                        withFont: Fonts.Timeline.boxContent!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 0)
        //boxTop.constant         = (index == 0) ? Sizing.Timeline.extraForFirstRow : 0.0
        headerHeight.constant   = heightForHeader
        contentHeight.constant  = heightForContent
        boxHeight.constant      = heightForContent + Sizing.Timeline.padding
        boxHeaderHeight.constant = heightForHeader + Sizing.Timeline.padding/2 + boxHeight.constant
        layoutIfNeeded()
    }

}
