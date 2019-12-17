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
    var poop: [CGFloat] = []
    
    
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
        contentSize = CGSize(width: UI.Sizing.Scroll.width*4, height: UI.Sizing.Scroll.height-1)
        contentInset = UIEdgeInsets(top: 0, left: UI.Sizing.Scroll.width*(1/4), bottom: 0, right: 0)
        objectSettings()
        constraints()
        
        print(1.0/UI.Sizing.Scroll.width*(1/4), UI.Sizing.Scroll.width*(1/4))
        poop = Array(stride(from: -1.0, to: 0.0, by: 1.0/(UI.Sizing.Scroll.width*(1/4))))
        print(poop.count)
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
        let diff = UI.Sizing.Header.expandedHeight-UI.Sizing.Header.minimizedHeight
        // LEFT (drag finger right)
        if scrollView.contentOffset.x <= -UI.Sizing.Scroll.width*(1/4) {
            scrollView.contentOffset.x = -UI.Sizing.Scroll.width*(1/4)
            ratio = 1-(-UI.Sizing.Scroll.width*(1/4)/UI.Sizing.Scroll.width)
        }
        //ratio = (ratio >= 1) ? 1.0 : ratio
        ratio = (ratio <= 0) ? 0.0 : ratio
        newConstant = (ratio > 1) ? ratio*UI.Sizing.Header.expandedHeight : ratio*diff + UI.Sizing.Header.minimizedHeight
        if contentOffset.x < 0.0 {
            let x = -UI.Sizing.Scroll.width*(1/4)
            print("------------------------")
            let y = -Int(ceil(contentOffset.x))
            let z = Int(poop.count)-Int(ceil(poop[y]*x))+Int(y)
            print(Int(poop.count),Int(ceil(poop[y]*x)), z)
            print("offset:    ",y,
                  "\narray:    ",poop[y],
                  "\narray-x:  ",poop[y]*x,
                  "\nnewArray: ",poop[z])
//            contentOffset.x =  (y > 0)
//                ? poop[y]
//                : poop[z]
        }
        else if scrollView.contentOffset.x == 0.0 { /*pass */ }
        // RIGHT (drag finger left)
        else if scrollView.contentOffset.x > 0.0 { /*pass */ }
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
