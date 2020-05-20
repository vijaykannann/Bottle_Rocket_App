//
//  CustomTabViewController.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit

class CustomTabViewController: MainTabBarController {

    override func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let lunch    = knTabBarItem(icon: UIImage(named: "dish")!, title: "lunch")
        let interest = knTabBarItem(icon: UIImage(named: "hand_cursor")!, title: "interest")
        let red      = self.storyboard?.instantiateViewController(identifier: "LunchViewController")
        let green    = self.storyboard?.instantiateViewController(identifier: "InterestViewController")
        setTabBar(items: [lunch, interest])
        viewControllers = [red!, green!]
        normalColor = UIColor(red: (151.0/255.0), green: (151.0/255.0), blue: (151.0/255.0), alpha: 1.0)
    }
    
    
}
