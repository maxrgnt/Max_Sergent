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
    // Objects
    
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
        
        contentSize   = CGSize(width: Sizing.width, height: CGFloat(100.0))
        contentInset  = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        backgroundColor = .blue
        
        //roundCorners(corners: [.topLeft,.topRight], radius: Sizing.Scroll.radius)
        
        closure()
    }
    
    func resetContentInset() {
        contentInset = UIEdgeInsets(top: 0, left: Sizing.Scroll.limit, bottom: 0, right: 0)
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

}
