//
//  CellView.swift
//  homework07
//
//  Created by john john on 2017/7/13.
//  Copyright © 2017年 John. All rights reserved.
//

import UIKit

let colorfulAry: [UIColor] = [.rgb(red: 255, green: 0, blue: 0), .rgb(red: 255, green: 127, blue: 0), .rgb(red: 255, green: 255, blue: 0), .rgb(red: 0, green: 255, blue: 0), .rgb(red: 0, green: 0, blue: 255), .rgb(red: 75, green: 0, blue: 130), .rgb(red: 148, green: 0, blue: 211)]
let photoAry = ["001","002","003","004","005","007"]

class CellView: BaseCell, UICollectionViewDelegateFlowLayout {
    
    var black: Bool = true
    
    override func setupViews() {
        super.setupViews()
        
        setupViewAndConstraint(view: blackAndWhiteView)
        blackAndWhiteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeBlackWhiteColor)))
        
        setupViewAndConstraint(view: colorfulView)
        colorfulView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeColorful)))
        
        setupViewAndConstraint(view: photoView)
        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changePhoto)))
        photoView.isUserInteractionEnabled = true
        
    }
    
    func setupViewAndConstraint(view: UIView) {
        addSubview(view)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": view]))
    }
    
    let blackAndWhiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let colorfulView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: photoAry[Int(arc4random()) % photoAry.count])
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    func changeBlackWhiteColor() {
        
        blackAndWhiteView.backgroundColor = black ? .white : .black
        
        black = !black
        
    }
    
    var colorNumber = Int(arc4random()) % colorfulAry.count
    
    func changeColorful() {
        
        colorfulView.backgroundColor = colorfulAry[colorNumber]
        
        colorNumber = (colorNumber + 1) % colorfulAry.count
        
    }
    
    var photoNumber = Int(arc4random()) % photoAry.count
    
    func changePhoto() {
        
        photoView.image = UIImage(named: photoAry[photoNumber])
        
        photoNumber = (photoNumber + 1) % photoAry.count
        
    }
}
