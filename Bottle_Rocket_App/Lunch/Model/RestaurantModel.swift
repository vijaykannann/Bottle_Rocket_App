//
//  RestaurantModel.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import Foundation

struct RestaurantsModel: Codable {
    var restaurants: [RestaurantModel]
}

struct RestaurantModel: Codable {
 
    var backgroundImageURL: String
    var category: String
    var contact: ContactInfo?
    var location: locationInfo?
    var name: String
 
}

struct ContactInfo: Codable {
    var formattedPhone: String?
    var phone: String?
    var twitter: String?
}

struct locationInfo: Codable {
    var address: String?
    var crossStreet: String?
    var lat: Double?
    var lng: Double?
    var postalCode: String?
    var cc: String?
    var city: String?
    var state: String?
    var country: String?
    var formattedAddress: [String]?
}

