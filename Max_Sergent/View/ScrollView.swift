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
    var scrollLimit: CGFloat = 0.0
    var inverseScrollLimit: CGFloat = 0.0
    var desiredOffsets: [CGFloat] = []
    var offsetSets: [CGFloat: (left: Int, self: Int, right: Int)] = [:]
    
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
        
        // 5.0     |     3.0 | 0.60
        // 10.0    |     5.5 | 0.55
        // 50.0    |    25.5 | 0.51
        // 200.0   |   100.5 | 0.50
        // 2000.0  |  1000.7 | 0.50
        // 50000.0 | 25000.5 | 0.50
        scrollLimit = UI.Sizing.Scroll.width*(1/4)
        // making numerator 1.5 makes third column ratio trend to 0.33
        // making numerate 0.5 makes third column ratio trend to 1.0 (get across entire screen)
        inverseScrollLimit = 1.0/(scrollLimit-1)
        
        desiredOffsets = Array(stride(from: -1.0, to: -scrollLimit, by: -inverseScrollLimit))
        desiredOffsets = desiredOffsets.map {round($0*1000)/1000}
        print("-------------")
        print(scrollLimit, inverseScrollLimit, desiredOffsets.count)
        print("-------------")
        print(desiredOffsets)
        var offsetSum: CGFloat = 0.0
        
        for (i, offset) in desiredOffsets.enumerated() {
            offsetSets[offset] = (left: (i-1) < 0 ? 0 : (i-1),
                                  self: i,
                                  right: (i+1) > desiredOffsets.count-1 ? desiredOffsets.count-1 : (i+1))
            offsetSum += offset
        }
        print("-------------")
        for x in offsetSets {
//            print(x)
        }
        //print("-------------")
        var newOffset: CGFloat = 0.0
        for (i,offset) in desiredOffsets.enumerated() {
            if i == 0 {
                newOffset = desiredOffsets[0]
            }
            else {
                let found = desiredOffsets[offsetSets[newOffset]!.right]
                newOffset = found
//                print("i: ",i
//                    ," | new:",newOffset
//                    ," | need:",offset
//                    ," | dict:",offsetSets[newOffset]!
//                    ," | found:",found)
            }
        }
        for key in Array(offsetSets.keys.sorted().reversed().prefix(upTo: 5)) {
            print(key, " | ",offsetSets[key]!)
        }
        print("----------------")
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
            
            // if i wanted to limit the scroll to 5, set scrollLimit to 10 (double) with inverseScrollLimit of 1
            // i want an array of [-1, -1.9, -2.7, -3.4, -4.0, -4.5, -4.9, -5.2, -5.4, -5.5]
            // the array is slowly moving the contentOffset further to -5 (more negative)
            // but doing so with less magnitude each time!
            
//            let offsetToIndex = -Int(ceil(contentOffset.x))
//            print("offset:",contentOffset.x,
//                  " index:",offsetToIndex,
//                  " abs:",abs(contentOffset.x),
//                  " desired:",desiredOffsets[offsetToIndex])
//            (offsetToIndex >= 0 && contentOffset.x >= -1)
//                ? print("true  : ",desiredOffsets[offsetToIndex])
//                : print("false : ",desiredOffsets[offsetSets[contentOffset.x]!.right])
//            print("----------------")
//            contentOffset.x = (offsetToIndex >= 0 && contentOffset.x >= -1)
//                ? desiredOffsets[offsetToIndex]
//                : desiredOffsets[offsetSets[contentOffset.x]!.right]
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
