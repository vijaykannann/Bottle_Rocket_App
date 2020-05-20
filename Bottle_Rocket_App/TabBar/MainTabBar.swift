//
//  MainTabBar.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit

class knTabBar: UITabBar {
    // (1)
    var kn_items = [knTabBarItem]()
    convenience init(items: [knTabBarItem]) {
        self.init()
        kn_items = items
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    override var tintColor: UIColor! {
        didSet {
            for item in kn_items {
                item.color = tintColor
            }}}

    func setupView() {
        backgroundColor = UIColor(red: (42.0/255.0), green: (42.0/255.0), blue: (42.0/255.0), alpha: 1.0)
        if kn_items.count == 0 { return }
        
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = .gray
        line.height(1)
        
        addSubviews(views: line)
        line.horizontal(toView: self)
        line.top(toView: self)
        
        var horizontalConstraints = "H:|"
        let itemWidth: CGFloat = screenWidth / CGFloat(kn_items.count)
        for i in 0 ..< kn_items.count {
            let item = kn_items[i]
            addSubviews(views: item)
            if item.itemHeight == 0 {
                item.vertical(toView: self)
            }
            else {
                item.bottom(toView: self)
                item.height(item.itemHeight)
            }
            item.width(itemWidth)
            horizontalConstraints += String(format: "[v%d]", i)
            if item.lock == false {
                item.color = tintColor
            }
        }
        
        horizontalConstraints += "|"
        addConstraints(withFormat: horizontalConstraints, arrayOf: kn_items)
    }
}
