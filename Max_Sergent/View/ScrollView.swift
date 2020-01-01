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
    func scrollMoveMenu(toPage: Int)
}

class Scroll: UIScrollView, UIScrollViewDelegate {
    
    //MARK: Definitions
    // Delegate
    var customDelegate : ScrollDelegate!
    // Constraints
    var height:   NSLayoutConstraint!
    // Objects
    let overview = Overview()
    let work = Work()
    let page3 = UILabel()
    let page4 = UILabel()
    let page5 = UILabel()
    lazy var pages = [overview,work,page3,page4,page5]
    
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
        let pageCount = CGFloat(pages.count)
        contentSize = CGSize(width: UI.Sizing.Scroll.width*pageCount, height: CGFloat(0.0))
        contentInset = UIEdgeInsets(top: 0, left: UI.Sizing.Scroll.limit, bottom: 0, right: 0)
        objectSettings()
        constraints()
    }
    
    //MARK: Object Settings
    func objectSettings() {
        
        addSubview(overview)
        overview.setup()
        addSubview(work)
        work.setup()
        addSubview(page3)
        page3.backgroundColor = .darkGray
        addSubview(page4)
        page4.backgroundColor = .darkGray
        addSubview(page5)
        page5.backgroundColor = .darkGray
    }
    
    //MARK: Constraints() {
    func constraints() {
        pageConstraints()
    }
    
    //MARK: Scroll Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        contentOffset.x = (contentOffset.x < -UI.Sizing.Scroll.limit) ? -UI.Sizing.Scroll.limit : contentOffset.x
        let ratio = (1-(contentOffset.x/UI.Sizing.Scroll.width) <= 0) ? 0.0 : 1-(contentOffset.x/UI.Sizing.Scroll.width)
        let diff = UI.Sizing.Header.expandedHeight-UI.Sizing.Header.minimizedHeight
        let newConstant = (ratio > 1) ? ratio*UI.Sizing.Header.expandedHeight : ratio*diff + UI.Sizing.Header.minimizedHeight
        alpha = (ratio > 1) ? 1-(contentOffset.x/(-UI.Sizing.Scroll.limit)) : 1
        
        let meh = contentOffset.x / UI.Sizing.Scroll.width
        work.alpha = (meh <= 1.0) ? meh : 1.0
        
        var page = Int(floor(Double(contentOffset.x)/Double(UI.Sizing.Scroll.width)))
        page = (page <= 0) ? 0 : page
        
        self.customDelegate.adjustHeader(toHeight: newConstant)
        self.customDelegate.scrollMoveMenu(toPage: page)
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        resetLeftInset()
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        resetLeftInset()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetLeftInset()
    }
    
    func resetLeftInset() {
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
