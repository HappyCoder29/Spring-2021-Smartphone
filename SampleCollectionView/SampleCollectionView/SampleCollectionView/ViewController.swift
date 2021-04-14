//
//  ViewController.swift
//  SampleCollectionView
//
//  Created by Ashish Ashish on 14/04/21.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let arr = [ UIImage(named: "Beverages"),
                UIImage(named: "Breakfast"),
                UIImage(named: "Chocolates"),
                UIImage(named: "Fruits"),
                UIImage(named: "Household"),
                UIImage(named: "Jams"),
                UIImage(named: "Readymeals"),
                UIImage(named: "Snacks"),
                UIImage(named: "Vegetables")
    
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCollectionViewCell
        
        cell.imgCell.image = arr[indexPath.row]
        
        return cell
    }
    
    
    


}

