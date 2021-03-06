//
//  ConceptCell.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import UIKit

class ConceptCell: UICollectionViewCell {

    //MARK: Definitions
    // Delegates
    // Constraints
    var titleHeight:   NSLayoutConstraint!
    // Objects
    var box     = UIView()
    var icon    = UIImageView()
    var title  = UILabel()
    // Variables
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup {
            constraints()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    //MARK: Settings
    func setup(closure: () -> Void) {
        
        backgroundColor = .clear

        contentView.addSubview(box)
        box.roundCorners(corners: [.topLeft,.topRight,.bottomLeft,.bottomRight], radius: Sizing.Concepts.boxRadius)
        
        box.addSubview(icon)
        icon.backgroundColor     = .clear
        icon.clipsToBounds       = true
        icon.layer.masksToBounds = true
        icon.contentMode         = .scaleAspectFill
        
        addSubview(title)
        title.numberOfLines   = 2
        title.textAlignment   = .center
        title.backgroundColor = .clear
        title.font            = Fonts.Concepts.title
        
        closure()
    }
     
    func resize() {
        let labelText =  (title.text ?? Constants.placeholder)!
        let heightForTitle = Fonts.calculateLabelHeight(for: labelText,
                                                        withFont: Fonts.Concepts.title!,
                                                        withWidth: Sizing.Concepts.contentWidth,
                                                        numberOfLines: title.numberOfLines)
        titleHeight.constant = heightForTitle
        Sizing.Concepts.titleHeight = heightForTitle
        layoutIfNeeded()
    }

}
