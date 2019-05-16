//
//  ViewController.swift
//  Brain Print App
//
//  Created by DarthMaul on 5/16/19.
//  Copyright © 2019 DarthMaul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    let pants =	["pant1", "pant2", "pant3", "pant4", "pant5",  ]
    let pantsImages : [UIImage] = [
        UIImage(named: "pant1")!,
        UIImage(named: "pant2")!,
        UIImage(named: "pant3")!,
        UIImage(named: "pant4")!,
        UIImage(named: "pant5")!,
        
        
    ]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //var  layout = self.collectionView as! UICollectionViewFlowLayout
        //layout.sectionInset = 	UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pants.count;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for:  indexPath) as! CollectionViewCell
        cell.pantsLabel.text = pants[indexPath.item]
        cell.pantsImageView1.image = pantsImages[indexPath.item]
        return cell
    }
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

