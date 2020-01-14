//
//  Scroll.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol ScrollDelegate {
    func scrollSet(toPage: Int)
    func calculateRatio(for: CGFloat)
}

class Scroll: UIScrollView, UIScrollViewDelegate {
    
    //MARK: Definitions
    // Delegates
    var customDelegate: ScrollDelegate!
    // Constraints
    // Objects
    var page1 = Overview()
    var page2 = UIView()
    var page3 = UIView()
    lazy var pages = [page1,page2,page3]
    var scrollingFromMenu = false
    
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
        delegate                                  = self
        isPagingEnabled                           = true
        isUserInteractionEnabled                  = true
        alwaysBounceVertical                      = false
        alwaysBounceHorizontal                    = false
        showsVerticalScrollIndicator              = false
        showsHorizontalScrollIndicator            = false
        automaticallyAdjustsScrollIndicatorInsets = false
        backgroundColor                           = Colors.Scroll.background
        
        let pageCount = CGFloat(pages.count)
        contentSize   = CGSize(width: Sizing.width*pageCount, height: CGFloat(0.0))
        contentInset  = UIEdgeInsets(top: 0, left: Sizing.Scroll.limit, bottom: 0, right: 0)
        
        //roundCorners(corners: [.topLeft,.topRight], radius: Sizing.Scroll.radius)
        
        addSubview(page1)
        page1.roundCorners(corners: [.topLeft], radius: Sizing.Scroll.radius)
        page1.backgroundColor = .darkGray
        page1.setup() {
            page1.constraints()
        }
        addSubview(page2)
        page2.backgroundColor = .darkGray
//        page2.roundCorners(corners: [.topLeft,.topRight], radius: Sizing.Scroll.radius)
        //page2.setup()
        addSubview(page3)
        page3.backgroundColor = .darkGray
        page3.roundCorners(corners: [.topRight], radius: Sizing.Scroll.radius)
        //page3.setup()
        
        closure()
    }
    
    func resetContentInset() {
        contentInset = UIEdgeInsets(top: 0, left: Sizing.Scroll.limit, bottom: 0, right: 0)
    }
    
    //MARK: Scroll Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Make sure user can not scroll backwards past scroll limit
        contentOffset.x = (contentOffset.x < -Sizing.Scroll.limit) ? -Sizing.Scroll.limit : contentOffset.x
        
        let newPage = movePage(forOffset: contentOffset.x)
        self.customDelegate.scrollSet(toPage: newPage)
        self.customDelegate.calculateRatio(for: contentOffset.x)
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
    
    //MARK: Adjusting State
    func movePage(forOffset offset: CGFloat) -> Int {
        let offset = Double(offset)
        let width = Double(Sizing.width)
        let floorOfRatio = floor(offset/width)
        let page = Int(floorOfRatio)
        return (page <= 0) ? 0 : page
    }
    
    func scaleInversely(with scalar: CGFloat) {
        alpha = (scalar < 0.0) ? 1+scalar : 1.0
    }


}
