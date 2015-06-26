//
//  ProductCell.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var blurView : UIView!
    
    var blurViewFrame : CGRect!
    
    override func awakeFromNib() {
        
        titleLabel.font = UIFont(name: MegaTheme.fontName, size: 14)
        titleLabel.textColor = UIColor.blackColor()
        
        priceLabel.font = UIFont(name: MegaTheme.fontName, size: 10)
        priceLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
        
        layer.borderColor = UIColor(white: 0.9, alpha: 1.0).CGColor
        layer.borderWidth = 0.3
    }
    
    func setCellSelected(selected : Bool){
        
        if selected {
            
            blurViewFrame = blurView.frame
            var frame = self.frame
            frame.origin = CGPointMake(0, 0)
            
            var height = frame.size.height
            
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                self.blurView.frame = frame
                
                }, completion: { (finished: Bool) in
                    
            })
        }else{
            
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                self.blurView.frame = self.blurViewFrame
                
                }, completion: { (finished: Bool) in
                    
            })
        }
    }
}
