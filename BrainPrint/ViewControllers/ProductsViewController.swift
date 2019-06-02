//
//  ViewController.swift
//  Brain Print App
//
//  Created by DarthMaul on 5/16/19.
//  Copyright © 2019 DarthMaul. All rights reserved.
//

import UIKit
class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel?
    @IBAction func plus(_ sender: Any) {
        
    }
}



class ProductsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let pants =	["pant1", "pant2", "pant3", "pant4", "pant5"]
    let pantsImages : [UIImage] = [
        UIImage(named: "pant1")!,
        UIImage(named: "pant2")!,
        UIImage(named: "pant3")!,
        UIImage(named: "pant4")!,
        UIImage(named: "pant5")!,
    ]
    
    var refresher:UIRefreshControl!
    let bottomContent = ["About", "Address", "Contact", "Info", "Follow us"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        
//        collectionView.register(UINib(nibName: "AppFeedCell", bundle: .main), forCellWithReuseIdentifier: "appFeedCell")
        //var  layout = self.collectionView as! UICollectionViewFlowLayout
        //layout.sectionInset = 	UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    @objc func loadData() {
        stopRefresher()
    }
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as! TableReusableView
        footer.configureTableView(frame: view.frame)
        return footer
    }
}

extension ProductsViewController : UICollectionViewDelegate{
    
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


extension ProductsViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for:  indexPath) as! CollectionViewCell
        cell.descriptionLabel.text = pants[indexPath.item]
        cell.productImageView.image = pantsImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pants.count;
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bottomContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tb_cell", for: indexPath) as! CustomTableViewCell
        cell.label?.text = bottomContent[indexPath.row]
        //        cell.plus?.setImage(UIImage(named: "plus"), for: .normal)
        return cell
    }
}


