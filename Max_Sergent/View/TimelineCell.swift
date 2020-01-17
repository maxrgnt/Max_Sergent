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
    var iconHeight:     NSLayoutConstraint!
    var iconWidth:      NSLayoutConstraint!
    var distinctionWidth: NSLayoutConstraint!
    var contentHeight:  NSLayoutConstraint!
    var contentLeading: NSLayoutConstraint!
    // Objects
    var line    = UILabel()
    var box     = UIView()
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
        backgroundColor = Colors.Timeline.background
        
        addSubview(line)
        line.backgroundColor = Colors.Timeline.line
        
        addSubview(box)
        box.backgroundColor = Colors.Overview.box
        box.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Timeline.boxRadius)
        
        box.addSubview(icon)
        icon.clipsToBounds       = true
        icon.layer.masksToBounds = true
        icon.contentMode         = .scaleAspectFill
        
        box.addSubview(header)
        header.numberOfLines   = 1
        header.textAlignment   = .left
        header.backgroundColor = .clear
        header.font            = Fonts.Timeline.boxHeader
        header.textColor       = Colors.Timeline.boxHeader
        
        box.addSubview(distinction)
        distinction.numberOfLines   = 1
        distinction.textAlignment   = .center
        distinction.backgroundColor = Colors.Timeline.boxDistinctionBackground
        distinction.font            = Fonts.Timeline.boxDistinction
        distinction.textColor       = Colors.Timeline.boxDistinctionText
        
        box.addSubview(content)
        content.numberOfLines   = 0
        content.textAlignment   = .left
        content.backgroundColor = .clear
        content.lineBreakMode   = .byWordWrapping
        content.font            = Fonts.Timeline.boxContent
        content.textColor       = Colors.Timeline.boxContent
        
        closure()
    }
    
    func calcHeights() -> CGFloat {
        let contentFrame = content.frameForLabel(text: content.text!,
                                                 font: content.font!,
                                                 numberOfLines: content.numberOfLines,
                                                 width: Sizing.Timeline.contentWidth)
        return contentFrame.height
    }
    
    func calcDistinctionWidth() {
        let distinctionFrame = distinction.frameForLabel(text: distinction.text!,
                                                         font: distinction.font!,
                                                         numberOfLines: 1)
        distinctionWidth.constant = distinctionFrame.width + Sizing.padding/2
        let radius = 0.094 * min(distinctionFrame.width, distinctionFrame.height)
        distinction.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: radius)
    }
    
    func resize(forIndex index: Int) {
        let calcHeight = calcHeights()
        boxTop.constant         = (index == 0) ? Sizing.padding/2 : 0.0
        contentHeight.constant  = calcHeight
        calcDistinctionWidth()
        let heightForHeader = Fonts.calculateLabelHeight(for: header.text!,
                                                        withFont: Fonts.Timeline.boxHeader!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 1)
        let heightForDistinction = Fonts.calculateLabelHeight(for: distinction.text!,
                                                        withFont: Fonts.Timeline.boxDistinction!,
                                                        withWidth: distinctionWidth.constant,
                                                        numberOfLines: 1)
        let heightForContent = Fonts.calculateLabelHeight(for: content.text!,
                                                        withFont: Fonts.Timeline.boxContent!,
                                                        withWidth: Sizing.Timeline.contentWidth,
                                                        numberOfLines: 0)
        boxHeight.constant = heightForHeader + heightForDistinction + heightForContent + Sizing.padding
        layoutIfNeeded()
    }

}
