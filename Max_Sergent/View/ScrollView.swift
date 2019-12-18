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
    func poop(toHeight: CGFloat)
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
        alwaysBounceHorizontal = false
        showsHorizontalScrollIndicator = false
        automaticallyAdjustsScrollIndicatorInsets = false
        contentSize = CGSize(width: UI.Sizing.Scroll.width*4, height: CGFloat(0.0))
        contentInset = UIEdgeInsets(top: 0, left: UI.Sizing.Scroll.limit, bottom: 0, right: 0)
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
        // LEFT (drag finger right)
        if contentOffset.x < 0.0 { /* pass */ }
        // RIGHT (drag finger left)
        else if scrollView.contentOffset.x > 0.0 { /*pass */ }
        
        contentOffset.x = (contentOffset.x < -UI.Sizing.Scroll.limit) ? -UI.Sizing.Scroll.limit : contentOffset.x
        
        let ratio = (1-(contentOffset.x/UI.Sizing.Scroll.width) <= 0) ? 0.0 : 1-(contentOffset.x/UI.Sizing.Scroll.width)
        alpha = (ratio > 1) ? 1-(contentOffset.x/(-UI.Sizing.Scroll.limit)) : 1
        
        let diff = UI.Sizing.Header.expandedHeight-UI.Sizing.Header.minimizedHeight
        let newConstant = (ratio > 1) ? ratio*UI.Sizing.Header.expandedHeight : ratio*diff + UI.Sizing.Header.minimizedHeight
        
        self.customDelegate.adjustHeader(toHeight: newConstant)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if contentOffset.x < 0.0 {
            setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if contentOffset.x < 0.0 {
            setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if contentOffset.x < 0.0 {
            setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
        }
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
