//
//  CustomCell.swift
//  BrainPrint
//
//  Created by DarthMaul on 5/30/19.
//  Copyright © 2019 DarthMaul. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var SocialMediaLabels: UILabel!
    @IBOutlet weak var PlusButtoms: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        // Initialization code
    }
    
    private func configureUI() {
        backgroundColor = .clear
        SocialMediaLabels.textColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
