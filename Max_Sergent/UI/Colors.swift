//
//  Colors.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/13/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
    
    /* Alter color scheme here  */
    static var primaryBackground:   UIColor!
    static var secondaryBackground: UIColor!
    static var tertiaryBackground:  UIColor!
    static var primaryFontColor:    UIColor!
    static var secondaryFontColor:  UIColor!
    static var footerEffectStyle:   String!
    /****************************/
    
}

extension ViewController {
    
    func resetColorScheme() {

        let primaryBackground   = Data.colorScheme[Constants.Data_Key.background1]!
        let secondaryBackground = Data.colorScheme[Constants.Data_Key.background2]!
        let tertiaryBackground  = Data.colorScheme[Constants.Data_Key.background3]!
        let primaryFontColor    = Data.colorScheme[Constants.Data_Key.font1]!
        let secondaryFontColor  = Data.colorScheme[Constants.Data_Key.font2]!
        let footerEffectStyle   = Data.colorScheme[Constants.Data_Key.effectStyle]!

        Colors.primaryBackground   = UIColor(hexFromString: primaryBackground,   alpha: 1.0)
        Colors.secondaryBackground = UIColor(hexFromString: secondaryBackground, alpha: 1.0)
        Colors.tertiaryBackground  = UIColor(hexFromString: tertiaryBackground,  alpha: 1.0)
        Colors.primaryFontColor    = UIColor(hexFromString: primaryFontColor,    alpha: 1.0)
        Colors.secondaryFontColor  = UIColor(hexFromString: secondaryFontColor,  alpha: 1.0)
        Colors.footerEffectStyle   = footerEffectStyle
        
        //ViewController
        view.backgroundColor                                = Colors.primaryBackground
        watermark.textColor                                 = Colors.secondaryBackground
        ViewController.lastUpdate.textColor                 = Colors.secondaryBackground
        //Header
        header.name.textColor                               = Colors.primaryFontColor
        let gradientTop                                     = Colors.primaryBackground.withAlphaComponent(0.0).cgColor
        let gradientBottom                                  = Colors.primaryBackground.withAlphaComponent(1.0).cgColor
        header.gradient.colors                              = [gradientTop, gradientBottom]
        //Scroll
        scroll.pages.forEach { page in
            page.backgroundColor                            = Colors.secondaryBackground
        }
        //Overview
        scroll.page1.titleTextColor                         = Colors.primaryFontColor
        scroll.page1.contentTextColor                       = Colors.secondaryFontColor
        scroll.page1.boxBackgroundColor                     = Colors.tertiaryBackground
        scroll.page1.reloadData()
        //Timeline
        scroll.page2.timelineRefresh.title.textColor        = Colors.primaryFontColor
        scroll.page2.timelineRefresh.line.backgroundColor   = Colors.primaryFontColor
        scroll.page2.timelineRefresh.node.backgroundColor   = Colors.primaryFontColor
        scroll.page2.sectionBackgroundColor                 = Colors.secondaryBackground
        scroll.page2.lineColor                              = Colors.primaryFontColor
        scroll.page2.titleTextColor                         = Colors.primaryFontColor
        let edu                                             = Data.colorScheme[Constants.Data_Key.education]!
        let exp                                             = Data.colorScheme[Constants.Data_Key.experience]!
        let proj                                            = Data.colorScheme[Constants.Data_Key.project]!
        scroll.page2.eduColor                               = UIColor(hexFromString: edu,  alpha: 1.0)
        scroll.page2.expColor                               = UIColor(hexFromString: exp,  alpha: 1.0)
        scroll.page2.projColor                              = UIColor(hexFromString: proj, alpha: 1.0)
        scroll.page2.contentTextColor                       = Colors.secondaryFontColor
        scroll.page2.boxColor                               = Colors.tertiaryBackground
        scroll.page2.reloadData()
        //Details
        scroll.page3.originDate.textColor                   = Colors.secondaryFontColor
        scroll.page3.asOf.textColor                         = Colors.secondaryFontColor
        scroll.page3.header.textColor                       = Colors.primaryFontColor
        scroll.page3.pie.backgroundColor                    = Colors.tertiaryBackground
        scroll.page3.pieText.percentTextColor               = Colors.primaryFontColor
        scroll.page3.pieText.legendTextColor                = Colors.secondaryFontColor
        scroll.page3.pieText.setNeedsDisplay()
        scroll.page3.concepts.boxBackgroundColor            = Colors.tertiaryBackground
        scroll.page3.concepts.titleTextColor                = Colors.secondaryFontColor
        scroll.page3.concepts.header.textColor              = Colors.primaryFontColor
        scroll.page3.concepts.collection.reloadData()
        //Footer
        let effect  = (Colors.footerEffectStyle == "dark")
                    ? UIBlurEffect(style: .dark)
                    : UIBlurEffect(style: .light)
        let textColor = (Colors.footerEffectStyle == "dark")
                      ? UIColor.white
                      : UIColor.black
        footer.blur.effect                                  = effect
        footer.vibrancy.effect                              = effect
        //Menu
        footer.menu.labels.forEach { label in
            label.textColor                                  = textColor
        }
    }
    
}
