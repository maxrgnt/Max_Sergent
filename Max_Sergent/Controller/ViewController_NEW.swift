//
//  ViewController_NEW.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/8/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

class ViewController_NEW: UIViewController, Menu_NEWDelegate, Scroll_NEWDelegate {
    
    let header = Header_NEW()
    let scroll = Scroll_NEW()
    let footer = Footer_NEW()
    
    override func viewDidLoad() {
        print("Hello World!")
        view.backgroundColor = .darkGray
        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        // App background color is light, whether in light or dark mode make status bar dark.
        return .darkContent
    }
    
    //MARK: Setup
    func setup() {
        objectSettings()
        constraints()
    }
    
    //MARK: Settings
    func objectSettings() {
        view.addSubview(header)
        header.setup()
        view.addSubview(scroll)
        scroll.setup()
        scroll.customDelegate = self
        view.addSubview(footer)
        footer.setup()
        footer.menu.customDelegate = self
         
        scroll.page1.stats.track1.animateFill(to: CGFloat.pi*2)
        scroll.page1.stats.track2.animateFill(to: CGFloat.pi*0.33)
        scroll.page1.stats.track3.animateFill(to: CGFloat.pi*0.66)
        scroll.page1.stats.track4.animateFill(to: CGFloat.pi*0.40)

//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//
//            DispatchQueue.global(qos: .background).async {
//                print("This is run on the background queue")
//
//                DispatchQueue.main.async {
//                    print("This is run on the main queue, after the previous code in outer block")
//                }
//            }
//        }
    }
    
    //MARK: Functionality
    
    //MARK: Custom Delegates
    func menuSet(toPage page: Int) {
        footer.menu.canSetFromMenu = false
        let newX = UI.Sizing.Scroll.width * CGFloat(page)
        let newOffset = CGPoint(x: newX, y: 0.0)
        scroll.setContentOffset(newOffset, animated: true)
    }
    
    func scrollSet(toPage page: Int) {
        if footer.menu.currentPage != page {
            footer.menu.currentPage = page
            footer.menu.setAlphaForPage()
            footer.menu.canSetFromMenu = true
        }
    }
    
    func calculateRatio(for contentOffset: CGFloat) {
        // The scale factor is inversely related to the ratio of the currentOffset.x to Scroll.width
        // If the scrollview has been offset 20% the scale factor should be 80%
        // As the scrollview moves right the scale factor shrinks the header
        let inverseScalar = (contentOffset/UI_NEW.Sizing.Scroll.width)
        var directScalar = 1-(contentOffset/UI_NEW.Sizing.Scroll.width)
        // If the scale factor goes negative, reset to zero
        directScalar = (directScalar <= 0) ? 0.0 : directScalar
        
        header.scaleDirectly(with: directScalar)
        header.scaleInversely(with: inverseScalar)
        scroll.page1.scaleInversely(with: inverseScalar)
    }
    
}
