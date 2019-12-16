//
//  ScrollView.swift
//  Max_Sergent
//
//  Created by Max Sergent on 12/16/19.
//  Copyright © 2019 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Scroll: UIScrollView, UIScrollViewDelegate {
    
    //MARK: Definitions
    // Constraints
    var height:   NSLayoutConstraint!
    // Objects
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
        isUserInteractionEnabled = true
        alwaysBounceHorizontal = true
        alwaysBounceVertical = false
        backgroundColor = .gray
        contentSize = CGSize(width: UI.Sizing.Scroll.width*3, height: CGFloat(0.0))
        objectSettings()
        constraints()
    }
    
    //MARK: Object Settings
    func objectSettings() {
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
        // LEFT
        if scrollView.contentOffset.x <= 0 {
            
        }
        // RIGHT
        else if scrollView.contentOffset.x > 0 {
            
        }
    }

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("Begin Decelerate")
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("End Drag")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("End Decelerate")
    }
    
}
