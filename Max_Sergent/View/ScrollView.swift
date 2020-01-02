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
        // Make sure user can not scroll backwards past scroll limit
        contentOffset.x = (contentOffset.x < -UI.Sizing.Scroll.limit) ? -UI.Sizing.Scroll.limit : contentOffset.x
        
        // If the scale factor goes negative, reset to zero
        var scaleFactor = 1-(contentOffset.x/UI.Sizing.Scroll.width)
        scaleFactor = (scaleFactor <= 0) ? 0.0 : scaleFactor
        
        let newHeight = (scaleFactor > 1.0)
            ? scaleFactor * UI.Sizing.Header.expandedHeight
            : scaleFactor * UI.Sizing.Header.heightDiff + UI.Sizing.Header.minimizedHeight
        
        let newPage = movePage(forOffset: contentOffset.x)
    
        adjustAlphas(forOffset: contentOffset.x, withScaleFactor: scaleFactor, andHeight: newHeight)
        self.customDelegate.scrollMoveMenu(toPage: newPage)
        self.customDelegate.adjustHeader(toHeight: newHeight)
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
        let width = Double(UI.Sizing.Scroll.width)
        let floorOfRatio = floor(offset/width)
        let page = Int(floorOfRatio)
        return (page <= 0) ? 0 : page
    }
    
    func adjustAlphas(forOffset offset: CGFloat, withScaleFactor scaleFactor: CGFloat, andHeight height: CGFloat) {
        // If the scaleFactor > 1 (the header is growing) fade out contents of header
        let headerAlpha = (scaleFactor > 1)
            ? 1-(offset/(-UI.Sizing.Scroll.limit))
            : 1.0
        // Find alpha depending on photo diameter
        let newPhotoDiameter = height - UI.Sizing.Header.pictureDiameter - UI.Sizing.Header.padding
        var scaleDiameter = newPhotoDiameter / UI.Sizing.Header.pictureDiameter
        scaleDiameter = (scaleDiameter > 1) ? 1.0 : scaleDiameter
        scaleDiameter = (scaleDiameter < 0) ? 0.0 : scaleDiameter
        print(scaleDiameter)
        
        // Use variables above to update respective alpha
        alpha = headerAlpha
        overview.alpha = scaleDiameter
        work.alpha = (1-scaleDiameter)
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
