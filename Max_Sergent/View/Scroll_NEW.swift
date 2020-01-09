//
//  Scroll_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/9/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

protocol Scroll_NEWDelegate {
//    func adjustHeader(toHeight: CGFloat)
    func scrollSet(toPage: Int)
//    func updateHeader(toHeight: CGFloat)
    func calculateRatio(for: CGFloat)
}

class Scroll_NEW: UIScrollView, UIScrollViewDelegate {
    
    //MARK: Definitions
    // Delegate
    var customDelegate : Scroll_NEWDelegate!
    // Constraints
    var height:   NSLayoutConstraint!
    // Objects
    let page1 = UILabel()
    let page2 = UILabel()
    let page3 = UILabel()
    lazy var pages = [page1,page2,page3]
    var scrollingFromMenu = false
    
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
        addSubview(page1)
        page1.backgroundColor = .black
        addSubview(page2)
        page2.backgroundColor = .darkGray
        addSubview(page3)
        page3.backgroundColor = .gray
    }
    
    //MARK: Scroll Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Make sure user can not scroll backwards past scroll limit
//        contentOffset.x = (contentOffset.x < -UI_NEW.Sizing.Scroll.limit) ? -UI_NEW.Sizing.Scroll.limit : contentOffset.x
        
        let newPage = movePage(forOffset: contentOffset.x)
    
//        adjustAlphas(forOffset: contentOffset.x, withScaleFactor: scaleFactor, andHeight: newHeight)
        self.customDelegate.scrollSet(toPage: newPage)
        self.customDelegate.calculateRatio(for: contentOffset.x)
//        self.customDelegate.updateHeader(toHeight: newHeight)
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
    
    func movePage(forOffset offset: CGFloat) -> Int {
        let offset = Double(offset)
        let width = Double(UI_NEW.Sizing.Scroll.width)
        let floorOfRatio = round(offset/width)
        let page = Int(floorOfRatio)
        return (page <= 0) ? 0 : page
    }
    
    func adjustAlphas(forOffset offset: CGFloat, withScaleFactor scaleFactor: CGFloat, andHeight height: CGFloat) {
//        // If the scaleFactor > 1 (the header is growing) fade out contents of header
//        let headerAlpha = (scaleFactor > 1)
//            ? 1-(offset/(-UI.Sizing.Scroll.limit))
//            : 1.0
//        // Find alpha depending on photo diameter
//        let newPhotoDiameter = height - UI.Sizing.Header.pictureDiameter - UI.Sizing.Header.padding
//        var scaleDiameter = newPhotoDiameter / UI.Sizing.Header.pictureDiameter
//        scaleDiameter = (scaleDiameter > 1) ? 1.0 : scaleDiameter
//        scaleDiameter = (scaleDiameter < 0) ? 0.0 : scaleDiameter
//        // Use variables above to update respective alpha
//        alpha = headerAlpha
//        page1.alpha = scaleDiameter
//        page2.alpha = (1-scaleDiameter)
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
