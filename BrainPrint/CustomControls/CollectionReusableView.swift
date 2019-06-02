//
//  CollectionReusableView.swift
//  BrainPrint
//
//  Created by DarthMaul on 6/2/19.
//  Copyright © 2019 DarthMaul. All rights reserved.
//

import UIKit
import Foundation

class TableReusableView: UICollectionReusableView {
    
//    @IBOutlet weak var tableView: UITableView!
    var tableView = UITableView()
    private let bottomContent = ["About", "Address", "Contact", "Info", "Follow us"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        configureTableView()
    }
    
    func configureTableView(frame : CGRect) {
        tableView.frame = frame
        addSubview(tableView)
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
    }

}

extension TableReusableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bottomContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.SocialMediaLabels?.text = bottomContent[indexPath.row]
        return cell
    }
}
