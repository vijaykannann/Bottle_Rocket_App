//
//  LunchViewController.swift
//  Bottle_Rocket_App
//
//  Created by VJ's iMAC on 20/05/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit

class LunchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let lunchVM = LunchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(UINib(nibName: "LunchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        lunchVM.delegate = self
        lunchVM.callWebApi()
    }
    
    //    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
    ////        DispatchQueue.main.async {
    ////            self.collectionView.reloadData()
    ////        }
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.title = "Lunch Tyme"
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(action(sender:)))
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(action(sender:)))
        
        self.navigationController?.navigationItem.rightBarButtonItems = [add, play]
    }
    
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
    }
}

extension LunchViewController: LunchDelegate {
    func finishLoadingData(error: String?) {
        if let error = error {
            print(error)
        } else {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
// load collection view
extension LunchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if let _ = self.lunchVM.restaurants {
            return 1
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.lunchVM.restaurants!.restaurants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getRestaurantCell(collectionView, cellForItemAt: indexPath)
    }
    
    func getRestaurantCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! LunchCollectionViewCell
        cell.contentHolderView.backgroundColor = .red
        let obj = self.lunchVM.restaurants!.restaurants[indexPath.row]
        
        cell.restaurantNameLbl.text = obj.name
        cell.categoryTypeLbl.text = obj.category
        cell.activityIndicator.startAnimating()
        ImageDownloadManager.shared.downloadImage(URL(string: obj.backgroundImageURL)!, indexPath: indexPath) { (image, url, index, err) in
            
            if let indexPathh = index {
                DispatchQueue.main.async {
                    if let path = collectionView.cellForItem(at: indexPathh) as? LunchCollectionViewCell {
                        path.activityIndicator.stopAnimating()
                        path.activityIndicator.isHidden = true
                        path.bannerImageview.image = image
                        path.bannerImageview.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return UIDevice.current.userInterfaceIdiom != .phone ? CGSize(width: self.view.frame.width/2, height: 180) : CGSize(width: self.view.frame.width, height: 180)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        controller.restModel = self.lunchVM.restaurants!.restaurants[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

