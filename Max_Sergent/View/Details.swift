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
    var headerHeight: NSLayoutConstraint!
    var asOfHeight: NSLayoutConstraint!
    var originDateHeight: NSLayoutConstraint!
    var originDateWidth: NSLayoutConstraint!
    var originDateCenterY: NSLayoutConstraint!
    var conceptsHeight: NSLayoutConstraint!
    // Objects
    var pie = Pie()
    var pieText = PieText()
    var header = UILabel()
    var asOf = UILabel()
    var originDate = UILabel()
    var concepts = Concepts()
    
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
        
        backgroundColor = .clear
        
        delegate                                  = self
        isPagingEnabled                           = false
        isUserInteractionEnabled                  = true
        alwaysBounceVertical                      = true
        alwaysBounceHorizontal                    = false
        showsVerticalScrollIndicator              = false
        showsHorizontalScrollIndicator            = false
        automaticallyAdjustsScrollIndicatorInsets = false
        
        contentInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        addSubview(header)
        header.numberOfLines   = 1
        header.textAlignment   = .left
        header.backgroundColor = .clear
        header.lineBreakMode   = .byWordWrapping
        header.text            = Constants.Pie.header
        header.font            = Fonts.Pie.header
        
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
        asOf.text            = Constants.Pie.asOf
        asOf.font            = Fonts.Pie.asOf
        
        addSubview(originDate)
        originDate.numberOfLines   = 3
        originDate.textAlignment   = .left
        originDate.backgroundColor = .clear
        originDate.lineBreakMode   = .byWordWrapping
        originDate.text            = Constants.Pie.originDate
        originDate.font            = Fonts.Pie.originDate
        
        addSubview(concepts)
        concepts.setup {
            concepts.constraints()
            concepts.resize()
        }
        
        //roundCorners(corners: [.topLeft,.topRight], radius: Sizing.Scroll.radius)
        
        closure()
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
        let headerFrame = header.frameForLabel(text: header.text!,
                                               font: header.font!,
                                               numberOfLines: header.numberOfLines,
                                               width: Sizing.paddedWidth)
        let asOfFrame = asOf.frameForLabel(text: asOf.text!,
                                           font: asOf.font!,
                                           numberOfLines: asOf.numberOfLines,
                                           width: Sizing.Pie.circleRadius)
        let originDateFrame = originDate.frameForLabel(text: originDate.text!,
                                                       font: originDate.font!,
                                                       numberOfLines: originDate.numberOfLines,
                                                       width: Sizing.Pie.circleRadius)
        headerHeight.constant      = headerFrame.height
        asOfHeight.constant        = asOfFrame.height
        originDateWidth.constant   = originDateFrame.width
        originDateHeight.constant  = originDateFrame.height
        originDateCenterY.constant = asOfFrame.height/2
        layoutIfNeeded()
        
        let verticalPadding = Sizing.Concepts.padding*2 + Sizing.Details.padding/2
        conceptsHeight.constant = concepts.collectionHeight.constant + concepts.headerHeight.constant + verticalPadding
        let contentHeight: CGFloat = headerHeight.constant + Sizing.paddedWidth + conceptsHeight.constant + Sizing.Menu.scrollOffset
        contentSize   = CGSize(width: Sizing.width, height: contentHeight)
    }
}
