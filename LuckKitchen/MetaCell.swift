//
//  MetaCell.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

class MetaCell: UITableViewCell {
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var subtitleLabel : UILabel!
    
    
    //Classes can implement this method to initialize state information after objects have been loaded from an Interface Builder archive (nib file).
    override func awakeFromNib() {
        
        titleLabel.font = UIFont(name: MegaTheme.fontName, size: 15)
        titleLabel.textColor = UIColor.blackColor()
        
        subtitleLabel.font = UIFont(name: MegaTheme.fontName, size: 12)
        subtitleLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
    }
}