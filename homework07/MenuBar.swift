//
//  MenuBar.swift
//  homework07
//
//  Created by john john on 2017/7/12.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var homeController: HomeController?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .rgb(red: 230, green: 32, blue: 31)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cell")
                
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .right)
        
        setupColletionView()
        setupHorizontalBar()
    }
    
    var horizonViewLeftAnchorConstraint: NSLayoutConstraint?
    
    func setupHorizontalBar() {
        let horizonView = UIView()
        horizonView.translatesAutoresizingMaskIntoConstraints = false
        horizonView.backgroundColor = .white
        
        addSubview(horizonView)
        
        horizonViewLeftAnchorConstraint = horizonView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizonViewLeftAnchorConstraint?.isActive = true
        horizonView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizonView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        horizonView.heightAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
    func setupColletionView() {
        addSubview(collectionView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionView]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 3, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    let imageName = ["black_and_white", "colorful", "photo"]
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageName[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = .rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
        
        let title = homeController?.navigationItem.titleView as? UILabel
        title?.text = homeController?.titleName[indexPath.item]
    }
}

class MenuCell: BaseCell {
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet{
            imageView.tintColor = isHighlighted ? .white : .rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    //let the tintColor become white when the cell is selected
    override var isSelected: Bool {
        didSet{
            imageView.tintColor = isSelected ? .white : .rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0(28)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(28)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
