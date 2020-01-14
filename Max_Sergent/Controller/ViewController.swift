//
//  ViewController.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, ScrollDelegate, MenuDelegate {
    
    let header = Header()
    let scroll = Scroll()
    let footer = Footer()
    
    override func viewDidLoad() {
        print("Hello World!")
        view.backgroundColor = Colors.ViewController.background
        setup() {
            constraints()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // App background color is light, whether in light or dark mode make status bar dark.
        return .darkContent
    }

    //MARK: Settings
    func setup(closure: () -> Void) {
        view.addSubview(header)
        header.setup() {
            header.constraints()
            header.resetNameHeight()
        }
        view.addSubview(scroll)
        scroll.setup() {
            scroll.constraints()
            scroll.resetContentInset()
        }
        scroll.customDelegate = self
        view.addSubview(footer)
        footer.setup() {
            footer.constraints()
        }
        footer.menu.customDelegate = self
        
        closure()
    }
    
    //MARK: Functionality
    
    //MARK: Custom Delegates
    func scrollSet(toPage page: Int) {
        if footer.menu.currentPage != page {
            footer.menu.currentPage = page
            footer.menu.setAlphaForPage()
            footer.menu.canSetFromMenu = true
        }
    }
    
    func menuSet(toPage page: Int) {
        footer.menu.canSetFromMenu = false
        let newX = Sizing.width * CGFloat(page)
        let newOffset = CGPoint(x: newX, y: 0.0)
        scroll.setContentOffset(newOffset, animated: true)
    }
    
    func calculateRatio(for contentOffset: CGFloat) {
        // The scale factor is inversely related to the ratio of the currentOffset.x to Scroll.width
        // If the scrollview has been offset 20% the scale factor should be 80%
        // As the scrollview moves right the scale factor shrinks the header
        let inverseScalar = (contentOffset/Sizing.Scroll.limit)
        var directScalar = 1-(contentOffset/Sizing.width)
        // If the scale factor goes negative, reset to zero
        directScalar = (directScalar <= 0) ? 0.0 : directScalar
        
        header.scaleDirectly(with: directScalar)
        header.scaleInversely(with: inverseScalar)
        scroll.scaleInversely(with: inverseScalar)
    }
    
}
