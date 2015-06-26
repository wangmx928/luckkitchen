//
//  ShipingDetailController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/13/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import UIKit

class FinalOrderDetailController: UITableViewController {

    
    @IBOutlet var productImageView : UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var salePriceLabel: UILabel!
    
    @IBOutlet var deliveryLabel: UILabel!
    @IBOutlet var deliveryValue: UILabel!
    
    @IBOutlet var paymentLabel: UILabel!
    @IBOutlet var paymentValue: UILabel!
    @IBOutlet var paymentValue2: UILabel!
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var addressValue: UILabel!
    
    @IBOutlet var summaryLabel: UILabel!
    @IBOutlet var subtotalLabel: UILabel!
    @IBOutlet var subtotalValue: UILabel!
    @IBOutlet var shippingLabel: UILabel!
    @IBOutlet var shippingValue: UILabel!
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var totalValue: UILabel!
    
    @IBOutlet var orderButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productImageView.image = UIImage(named: "product-1")
        productImageView.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).CGColor
        productImageView.layer.borderWidth = 0.4
        
        titleLabel.font = UIFont(name: MegaTheme.fontName, size: 17)
        titleLabel.textColor = MegaTheme.darkColor
        titleLabel.text = "Armani Jeans Shirt"
        
        detailsLabel.font = UIFont(name: MegaTheme.fontName, size: 12)
        detailsLabel.textColor = MegaTheme.lightColor
        detailsLabel.text = "Size M, Color Blue"
        
        priceLabel.font = UIFont(name: MegaTheme.fontName, size: 15)
        priceLabel.textColor = UIColor.blueColor()
        priceLabel.text = "$144"
        
        salePriceLabel.font = UIFont(name: MegaTheme.fontName, size: 12)
        salePriceLabel.textColor = MegaTheme.lightColor
        let salePrice = NSMutableAttributedString(string: "$177")
        salePrice.addAttribute(NSStrikethroughStyleAttributeName, value: 2, range: NSMakeRange(0, salePrice.length))
        salePriceLabel.attributedText = salePrice
        
        let fontSize : CGFloat = 12
        
        deliveryLabel.font = UIFont(name: MegaTheme.boldFontName, size: fontSize)
        deliveryLabel.textColor = MegaTheme.darkColor
        deliveryLabel.text = "DELIVERY METHOD"
        
        deliveryValue.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        deliveryValue.textColor = MegaTheme.lightColor
        deliveryValue.text = "USPS EXPRESS"
        
        paymentLabel.font = UIFont(name: MegaTheme.boldFontName, size: fontSize)
        paymentLabel.textColor = MegaTheme.darkColor
        paymentLabel.text = "PAYMENT METHOD"
        
        paymentValue.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        paymentValue.textColor = MegaTheme.lightColor
        paymentValue.text = "AMEX"
        
        paymentValue2.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        paymentValue2.textColor = MegaTheme.lightColor
        paymentValue2.text = "**** *******3476"
        
        addressLabel.font = UIFont(name: MegaTheme.boldFontName, size: fontSize)
        addressLabel.textColor = MegaTheme.darkColor
        addressLabel.text = "ADDRESS"
        
        addressValue.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        addressValue.textColor = MegaTheme.lightColor
        addressValue.text = "145 Spindle Avenue \nHollywood, California \nCA-32320, United States"
        
        summaryLabel.font = UIFont(name: MegaTheme.boldFontName, size: fontSize)
        summaryLabel.textColor = MegaTheme.darkColor
        summaryLabel.text = "SUMMARY"
        
        subtotalLabel.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        subtotalLabel.textColor = MegaTheme.lightColor
        subtotalLabel.text = "SUBTOTAL"
        
        subtotalValue.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        subtotalValue.textColor = MegaTheme.lightColor
        subtotalValue.text = "$144.99"
        
        shippingLabel.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        shippingLabel.textColor = MegaTheme.lightColor
        shippingLabel.text = "SHIPPING"
        
        shippingValue.font = UIFont(name: MegaTheme.fontName, size: fontSize)
        shippingValue.textColor = MegaTheme.lightColor
        shippingValue.text = "$4.00"
        
        totalLabel.font = UIFont(name: MegaTheme.boldFontName, size: 13)
        totalLabel.textColor = MegaTheme.darkColor
        totalLabel.text = "TOTAL"
        
        totalValue.font = UIFont(name: MegaTheme.boldFontName, size: 13)
        totalValue.textColor = MegaTheme.lightColor
        totalValue.text = "$148.99"
        
        orderButton.titleLabel?.font = UIFont(name: MegaTheme.boldFontName, size: 18)
        orderButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        orderButton.setTitle("Submit", forState: .Normal)
        orderButton.backgroundColor = UIColor(red: 0.14, green: 0.71, blue: 0.69, alpha: 1.0)
        orderButton.layer.cornerRadius = 20
        orderButton.layer.borderWidth = 0;
        orderButton.clipsToBounds = true;
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }else if indexPath.row == 3 {
            return 100
        }else if indexPath.row == 4 {
            return 180
        }
        else{
            return 60
        }
    }

}
