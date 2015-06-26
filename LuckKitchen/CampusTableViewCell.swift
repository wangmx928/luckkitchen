//
//  CampusTableViewCell.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/18/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit

class CampusTableViewCell: UITableViewCell {


    @IBOutlet weak var campusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        campusLabel.font = UIFont(name: MegaTheme.fontName, size: 15)
        campusLabel.textColor = UIColor.blackColor()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
