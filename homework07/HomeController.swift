//
//  ViewController.swift
//  homework07
//
//  Created by john john on 2017/7/12.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let titleName = ["Black & White", "Colorful", "Photo"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        titleLabel.text = "Black & White"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false

        setupCollectionView()
        setupMenuBar()
        
    }
    
    func setupCollectionView() {
        
        collectionView?.register(CellView.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.backgroundColor = .white
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true
        //讓VideoCell的頂端和navBar距離50pix(因為menuBar有50pix高)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        //讓VideoCell的捲軸的頂端和navBar距離50pix(因為menuBar有50pix高)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)

    }
    
    func setupMenuBar() {
        
        view.addSubview(menuBar)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": menuBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": menuBar]))
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true

    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellView
        
        let cellColor: [UIColor] = [.red, .white, .black]
        cell.backgroundColor = cellColor[indexPath.item]
        
        switch indexPath.item {
        case 0:
            cell.colorfulView.isHidden = true
            cell.blackAndWhiteView.isHidden = false
            cell.photoView.isHidden = true
        case 1:
            cell.colorfulView.isHidden = false
            cell.blackAndWhiteView.isHidden = true
            cell.photoView.isHidden = true

        case 2:
            cell.colorfulView.isHidden = true
            cell.blackAndWhiteView.isHidden = true
            cell.photoView.isHidden = false

        default:
            break
        }
        
        return cell
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        
        //此處在HomeController裡面，故此處的collectionView不是指menuBar
        collectionView?.scrollToItem(at: indexPath, at: .init(rawValue: .allZeros), animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.height - 50
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //scrollView.contentOffset.x是指當前collectionViewCell右上的x座標
        menuBar.horizonViewLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    //讓icon跟著collectionViewCell一起改變
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init(rawValue: .allZeros))
    }
}

