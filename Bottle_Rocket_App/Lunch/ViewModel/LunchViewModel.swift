//
//  LunchViewModel.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import Foundation

protocol LunchDelegate {
    func finishLoadingData(error: String?)
}

class LunchViewModel {
    var restaurants: RestaurantsModel?
    var delegate: LunchDelegate?
    
    func callWebApi() {
        var api = NetworkHelper()
        api.delegate = self
        if let url = URL(string: "https://s3.amazonaws.com/br-codingexams/restaurants.json") {
            api.callApi(url: url)
        }
    }
}

extension LunchViewModel: NeworkLoadingDelegate {
    func didApiFinishedLoadingWithError(error: Error?, message: String?, httpResponse: HTTPURLResponse?) {
        var messageStr: String? = nil
        if let error = error {
            messageStr = error.localizedDescription
        } else if let message = message {
            messageStr = message
        } else if let _ = httpResponse {
            messageStr = "Internal server error!!"
        }
        
        if let delegate = self.delegate {
            delegate.finishLoadingData(error: messageStr)
        }
    }
    
    func didApiFinishedLoadingWithSuccess(data: Any?) {
        if let data = data as? Data {
            do {
                let decoder = JSONDecoder()
                self.restaurants = try decoder.decode(RestaurantsModel.self, from: data)
                if let delegate = self.delegate {
                    delegate.finishLoadingData(error: nil)
                }
            } catch let error {
                self.didApiFinishedLoadingWithError(error: error, message: nil, httpResponse: nil)
            }
        }
    }
}
