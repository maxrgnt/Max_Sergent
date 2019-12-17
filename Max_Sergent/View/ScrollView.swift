//
//  ScrollView.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/16/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol ScrollDelegate {
    func adjustHeader(toHeight: CGFloat)
}

class Scroll: UIScrollView, UIScrollViewDelegate {
    
    //MARK: Definitions
    // Delegate
    var customDelegate : ScrollDelegate!
    // Constraints
    var height:   NSLayoutConstraint!
    // Objects
    let overview = Overview()
    let page1 = UILabel()
    let page2 = UILabel()
    let page3 = UILabel()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Setup
    func setup() {
        delegate = self
        isPagingEnabled = true
        isUserInteractionEnabled = true
        backgroundColor = UI.Colors.Overview.background
        alwaysBounceVertical = false
        showsVerticalScrollIndicator = false
        alwaysBounceHorizontal = true
        showsHorizontalScrollIndicator = false
        contentSize = CGSize(width: UI.Sizing.Scroll.width*4, height: CGFloat(0.0))
        objectSettings()
        constraints()
    }
    
    //MARK: Object Settings
    func objectSettings() {
        addSubview(overview)
        overview.setup()
        addSubview(page1)
        page1.backgroundColor = .blue
        addSubview(page2)
        page2.backgroundColor = .yellow
        addSubview(page3)
        page3.backgroundColor = .red
    }
    
    //MARK: Constraints() {
    func constraints() {
        pageConstraints()
    }
    
    //MARK: Scroll Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var ratio = 1-(contentOffset.x/UI.Sizing.Scroll.width)
        var newConstant: CGFloat = 0.0
        // LEFT (drag finger right)
        if scrollView.contentOffset.x <= 0 {
            ratio = (ratio >= 1) ? 1.0 : ratio
            newConstant = ratio*UI.Sizing.Header.expandedHeight
        }
        // RIGHT (drag finger left)
        else if scrollView.contentOffset.x > 0 {
            ratio = (ratio <= 0) ? 0.0 : ratio
            let diff = UI.Sizing.Header.expandedHeight-UI.Sizing.Header.minimizedHeight
            newConstant = (ratio*diff) + UI.Sizing.Header.minimizedHeight
        }
        self.customDelegate.adjustHeader(toHeight: newConstant)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        // pass
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // pass
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // pass
    }
    
    //MARK: Animate
    func animateTemplate() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut
            , animations: ({
                self.layoutIfNeeded()
            }), completion: { (completed) in
                // pass
        })
    }
}
