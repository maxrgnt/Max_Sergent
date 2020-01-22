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

class Scroll: UIScrollView, UIScrollViewDelegate, DetailsDelegate {    
    
    //MARK: Definitions
    // Delegates
    var customDelegate: ScrollDelegate!
    // Constraints
    // Objects
    var page1 = OverviewTable()
    var page2 = TimelineTable()
    var page3 = Details()
    var page3blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    var page3vibrancy = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: .light)))
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
        backgroundColor                           = .clear
        
        let pageCount = CGFloat(pages.count)
        contentSize   = CGSize(width: Sizing.width*pageCount, height: CGFloat(0.0))
        contentInset  = UIEdgeInsets(top: 0, left: Sizing.Scroll.limit, bottom: 0, right: 0)
        
        addSubview(page1)
        page1.roundCorners(corners: [.topLeft], radius: Sizing.Scroll.radius)
        page1.setup()
        addSubview(page2)
        page2.setup()
        addSubview(page3)
        page3.roundCorners(corners: [.topRight], radius: Sizing.Scroll.radius)
        page3.setup() {
            page3.constraints()
            page3.resize()
        }
        page3.customDelegate = self
        // Blur object settings
        addSubview(page3blur)
        page3blur.roundCorners(corners: [.topRight], radius: Sizing.Scroll.radius)
        page3blur.alpha = 0.0
        page3blur.clipsToBounds = true
        // Vibrancy object settings
        page3blur.contentView.addSubview(page3vibrancy)
        page3vibrancy.alpha = 0.0
        
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
    
    func setBlurAlpha(toAlpha: CGFloat) {
        if page3blur.alpha != toAlpha {
            UIView.animate(withDuration: 0.55, delay: 0.0,
                // 1.0 is smooth, 0.0 is bouncy
                usingSpringWithDamping: 0.7,
                // 1.0 corresponds to the total animation distance traversed in one second
                // distance/seconds, 1.0 = total animation distance traversed in one second
                initialSpringVelocity: 1.0,
                options: [.curveEaseInOut],
                // [autoReverse, curveEaseIn, curveEaseOut, curveEaseInOut, curveLinear]
                animations: {
                    //Do all animations here
                    self.page3blur.alpha = toAlpha
                    self.page3vibrancy.alpha = toAlpha
            }, completion: {
                   //Code to run after animating
                    (value: Bool) in
            })
        }
        print("alpha: ",page3blur.alpha)
        print("alpha: ",page3vibrancy.alpha)
    }


}
