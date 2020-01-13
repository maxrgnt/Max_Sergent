//
//  OverviewStats.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/12/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class OverviewStats: UIView {
    
    //MARK: Definitions
    // Constraints
    var x:   NSLayoutConstraint!
    // Objects
    let header = UILabel()
    let track1 = OverviewTrack()
    let track2 = OverviewTrack()
    let track3 = OverviewTrack()
    let track4 = OverviewTrack()
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UI_NEW.Colors.Overview.background
        objectSettings()
        constraints()
    }
    
    func objectSettings() {
        addSubview(header)
        header.numberOfLines = 1
        header.textAlignment = .left
        header.backgroundColor = .clear
        header.font = UI_NEW.Fonts.OverviewStats.header
        header.text = Constants_NEW.Overview.trackerHeader
        header.textColor = UI_NEW.Colors.OverviewStats.header
        
        for track in [track1, track2, track3, track4] {
            addSubview(track)
            track.setup()
        }
    }

}
