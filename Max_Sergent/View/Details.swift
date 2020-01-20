//
//  Details.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/18/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsDelegate {
    
}

class Details: UIScrollView, UIScrollViewDelegate {
    
    //MARK: Definitions
    // Delegates
    var customDelegate: DetailsDelegate!
    // Constraints
    var asOfHeight: NSLayoutConstraint!
    var originDateHeight: NSLayoutConstraint!
    var originDateWidth: NSLayoutConstraint!
    var originDateCenterY: NSLayoutConstraint!
    // Objects
    var pie = Pie()
    var pieText = PieText()
    var asOf = UILabel()
    var originDate = UILabel()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    func setup(closure: () -> Void) {
        
        backgroundColor = Colors.Details.background
        
        delegate                                  = self
        isPagingEnabled                           = true
        isUserInteractionEnabled                  = true
        alwaysBounceVertical                      = false
        alwaysBounceHorizontal                    = false
        showsVerticalScrollIndicator              = false
        showsHorizontalScrollIndicator            = false
        automaticallyAdjustsScrollIndicatorInsets = false
        
        contentSize   = CGSize(width: Sizing.width, height: CGFloat(100.0))
        contentInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(pie)
        pie.setup {
            pie.constraints()
        }
        addSubview(pieText)
        pieText.setup {
            pieText.constraints()
        }
        
        addSubview(asOf)
        asOf.numberOfLines   = 1
        asOf.textAlignment   = .left
        asOf.backgroundColor = .clear
        asOf.lineBreakMode   = .byWordWrapping
        asOf.text            = Constants.Details.asOf
        asOf.font            = Fonts.Details.asOf
        asOf.textColor       = Colors.Details.asOf
        
        addSubview(originDate)
        originDate.numberOfLines   = 3
        originDate.textAlignment   = .left
        originDate.backgroundColor = .clear
        originDate.lineBreakMode   = .byWordWrapping
        originDate.text            = Constants.Details.originDate
        originDate.font            = Fonts.Details.originDate
        originDate.textColor       = Colors.Details.originDate
        
        //roundCorners(corners: [.topLeft,.topRight], radius: Sizing.Scroll.radius)
        
        closure()
    }
    
    func resetContentInset() {
        contentInset = UIEdgeInsets(top: 0, left: Sizing.Scroll.limit, bottom: 0, right: 0)
    }
    
    //MARK: Scroll Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

    }
    
    //MARK: Adjusting State
    func resize() {
        let asOfFrame = asOf.frameForLabel(text: asOf.text!,
                                           font: asOf.font!,
                                           numberOfLines: asOf.numberOfLines,
                                           width: Sizing.Pie.circleRadius)
        let originDateFrame = originDate.frameForLabel(text: originDate.text!,
                                                       font: originDate.font!,
                                                       numberOfLines: originDate.numberOfLines,
                                                       width: Sizing.Pie.circleRadius)
        asOfHeight.constant        = asOfFrame.height
        originDateWidth.constant   = originDateFrame.width
        originDateHeight.constant  = originDateFrame.height
        originDateCenterY.constant = asOfFrame.height/2
        layoutIfNeeded()
    }
    
}
