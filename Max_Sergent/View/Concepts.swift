//
//  Concepts.swift
//  Max_Sergent
//
//  Created by Max Sergent on 1/20/20.
//  Copyright © 2020 Max Sergent. All rights reserved.
//

import Foundation
import UIKit

class Concepts: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    //MARK: Definitions
    // Delegates
    // Constraints
    var headerHeight: NSLayoutConstraint!
    var collectionHeight: NSLayoutConstraint!
    // Objects
    var header = UILabel()
    weak var collection: UICollectionView!
    
    //MARK: Initialization
    init() {
        // Initialize frame of view
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(closure: () -> Void) {
        
        setupCollectionView()
        
        addSubview(header)
        header.numberOfLines   = 1
        header.textAlignment   = .left
        header.backgroundColor = .clear
        header.lineBreakMode   = .byWordWrapping
        header.text            = Constants.Concepts.header
        header.font            = Fonts.Concepts.header
        header.textColor       = Colors.Concepts.title
        
        closure()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let flow = collection.collectionViewLayout as! UICollectionViewFlowLayout
        let itemSpacing: CGFloat = Sizing.Concepts.padding
        flow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let width = Sizing.paddedWidth - itemSpacing * CGFloat(Constants.Concepts.objectsPerRow - 1)
        flow.itemSize = CGSize(width: floor(width/Constants.Concepts.objectsPerRow), height: Sizing.Concepts.cellHeight)
        flow.minimumInteritemSpacing = Sizing.Concepts.padding
        flow.minimumLineSpacing = Sizing.Concepts.padding
        collection.setCollectionViewLayout(flow, animated: false)
        layout.scrollDirection = .vertical
        collection.alwaysBounceVertical = false
        collection.alwaysBounceHorizontal = false
        collection.backgroundColor = Colors.Details.background
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        addSubview(collection)
        self.collection = collection
        self.collection.dataSource = self
        self.collection.delegate = self
        self.collection.register(ConceptCell.self, forCellWithReuseIdentifier: Constants.Concepts.cellReuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Data.concepts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Concepts.cellReuseId, for: indexPath) as! ConceptCell
        
        cell.icon.image = UIImage(named: Data.concepts[indexPath.row][Constants.Data_Key.iconName] as! String)
        cell.title.text = (Data.concepts[indexPath.row][Constants.Data_Key.title] as! String)
        cell.resize()
        
        return cell
    }
    
    func resize() {
        let headerFrame = header.frameForLabel(text: header.text!,
                                               font: header.font!,
                                               numberOfLines: header.numberOfLines,
                                               width: Sizing.paddedWidth)
        headerHeight.constant = headerFrame.height
        let numberOfRows = ceil(CGFloat(Data.concepts.count)/Constants.Concepts.objectsPerRow)
        print("concept resize: \(numberOfRows)")
        let verticalPadding = (numberOfRows == 0) ? 0.0 : ((numberOfRows-1) * Sizing.Concepts.padding)
        collectionHeight.constant = (numberOfRows * Sizing.Concepts.cellHeight) + verticalPadding
        collection.contentSize = CGSize(width: Sizing.paddedWidth, height: collectionHeight.constant)
        layoutIfNeeded()
    }
    
}
