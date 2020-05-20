//
//  DetailViewController.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit
import MapKit
class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var mapView          : MKMapView!
    @IBOutlet weak var restrautNameLbl  : UILabel!
    @IBOutlet weak var catLbl           : UILabel!
    @IBOutlet weak var addLbl           : UILabel!
    @IBOutlet weak var numberLbl        : UILabel!
    @IBOutlet weak var twitterLbl       : UILabel!
    
    var restModel                       : RestaurantModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let play = UIBarButtonItem(image: UIImage(named: "arrows")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(didBackBtnPress(_:)))
        self.title        = "Lunch Tyme"
        self.navigationItem.leftBarButtonItems  = [ play]
        self.mapDetails()
        
        // Do any additional setup after loading the view.
    }
    
    

    
    @IBAction func didBackBtnPress(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension DetailViewController {
    
    
    fileprivate func mapDetails() {
        
        if let restModel = self.restModel {
            self.restrautNameLbl.text = restModel.name
            self.catLbl.text          = restModel.category
            
            if let location = restModel.location {
                if let long = location.lng, let lat = location.lat {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    
                    self.mapView.addAnnotation(annotation)
                    self.mapView.showAnnotations(self.mapView.annotations, animated: true)
                }
                self.addLbl.text = "\(location.address ?? "")\n\(location.crossStreet ?? "")"
            }
            self.numberLbl.text = restModel.contact?.phone ?? ""
            
            if let twi = restModel.contact?.twitter {
                self.twitterLbl.text = "@\(twi)"
            } else {
                self.twitterLbl.text = ""
            }
        }
    }
}
