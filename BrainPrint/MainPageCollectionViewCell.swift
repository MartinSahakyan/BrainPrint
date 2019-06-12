//
//  MainPageCollectionViewCell.swift
//  BrainPrint
//
//  Created by DarthMaul on 6/12/19.
//  Copyright © 2019 DarthMaul. All rights reserved.
//

import UIKit

class MainPageCollectionViewCell: UIViewController{
    
  
    @IBOutlet weak var MainImage: UIImageView!
    @IBOutlet weak var ShopWoman: UIImageView!
    @IBOutlet weak var ShopMan: UIImageView!
    @IBOutlet weak var NewRelease: UIImageView!
    @IBOutlet weak var ShopNowInOurInstator: UIImageView!
    
    
    
    
    
}
extension MainPageCollectionViewCell : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.gray.cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 0.5
    }
}


extension MainPageCollectionViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for:  indexPath) as! CollectionViewCell
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}
