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
            footer.menu.canSetFromMenu = true
            footer.menu.pages.forEach { (label) in
                label.font = (label.tag == page)
                    ? UI_NEW.Fonts.Menu.selected
                    : UI_NEW.Fonts.Menu.normal
                label.alpha = (label.tag == page)
                    ? 1.0
                    : 0.7
            }
        }
    }
    
}
