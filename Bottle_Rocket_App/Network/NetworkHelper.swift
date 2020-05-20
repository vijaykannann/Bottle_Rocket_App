//
//  NeworkHelper.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import Foundation

protocol NeworkLoadingDelegate {
    func didApiFinishedLoadingWithError(error: Error?, message: String?, httpResponse: HTTPURLResponse?)
    func didApiFinishedLoadingWithSuccess(data: Any?)
}

struct NetworkHelper {
    private let session = URLSession.shared
    var delegate: NeworkLoadingDelegate?
    
    func callApi(url: URL) {
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if error != nil {
                if let delegate = self.delegate {
                    delegate.didApiFinishedLoadingWithError(error: error, message: nil, httpResponse: nil)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    if let delegate = self.delegate {
                        delegate.didApiFinishedLoadingWithError(error: error, message: nil, httpResponse: response as? HTTPURLResponse)
                    }
                    return
            }
            guard let mime = httpResponse.mimeType, mime == "application/json" else {
                if let delegate = self.delegate {
                    delegate.didApiFinishedLoadingWithError(error: nil, message: "Wrong MIME type!", httpResponse: nil)
                }
                return
            }
            if let delegate = self.delegate {
                delegate.didApiFinishedLoadingWithSuccess(data: data)
            }
            
            // Do something...
        })
        task.resume()
    }
    
}
