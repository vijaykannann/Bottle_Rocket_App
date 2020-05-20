//
//  TabBarButton.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit

class knTabBarItem: UIButton {
    // (1)
    var itemHeight: CGFloat = 0
    // (2)
    var lock = false
    // (3)
    var color: UIColor = UIColor.lightGray {
        didSet {
            guard lock == false else { return }
            iconImageView.tintColor = color
            textLabel.textColor = color
        }}

    // (4)
    private let iconImageView = knUIMaker.makeImageView(contentMode: .scaleAspectFit)
    private let textLabel = knUIMaker.makeLabel(font: UIFont(name: "AvenirNext-Regular", size: 10)!,
                                        color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), alignment: .center)

    convenience init(icon: UIImage, title: String,
                    font: UIFont = UIFont.systemFont(ofSize: 11)) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = icon.withRenderingMode(.alwaysTemplate)
        textLabel.text = title
        textLabel.font = UIFont(name: font.fontName, size: 11)
        setupView()
    }

    // (5)
    private func setupView() {
        addSubviews(views: iconImageView, textLabel)
        iconImageView.top(toView: self, space: 4)
        iconImageView.centerX(toView: self)
        iconImageView.square()

        let iconBottomConstant: CGFloat = textLabel.text == "" ? -2 : -20
        iconImageView.bottom(toView: self, space: iconBottomConstant)

        textLabel.bottom(toView: self, space: -2)
        textLabel.centerX(toView: self)
    }
}
