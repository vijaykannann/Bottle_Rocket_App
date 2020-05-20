//
//  LunchCollectionViewCell.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit

class LunchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var contentHolderView: UIView!
    @IBOutlet weak var restaurantNameLbl: UILabel!
    @IBOutlet weak var categoryTypeLbl: UILabel!
    
    @IBOutlet weak var bannerImageview: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
