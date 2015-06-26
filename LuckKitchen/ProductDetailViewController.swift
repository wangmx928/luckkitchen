//
//  ProductDetailViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewController : UITableViewController {
    
    @IBOutlet var productImageView : UIImageView!
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var stockLabel : UILabel!
    @IBOutlet var priceLabel : UILabel!
    @IBOutlet var saleLabel  : UILabel!
    @IBOutlet var descriptionLabel  : UILabel!
    @IBOutlet var orderButton  : UIButton!
    
    //this value is passed from ShopViewController, as the selected product
    var selectedProduct: Product!
    //core data
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate could also be set in main.storyboard
        tableView.delegate = self
        tableView.dataSource = self
        
        productImageView.image = UIImage(named: selectedProduct.image)

        titleLabel.font = UIFont(name: MegaTheme.fontName, size: 15)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = selectedProduct.title
        
        stockLabel.font = UIFont(name: MegaTheme.fontName, size: 11)
        stockLabel.textColor = UIColor(white: 0.6, alpha: 1.0)
        stockLabel.text = "Availability: In Stock"
                
        priceLabel.font = UIFont(name: MegaTheme.fontName, size: 15)
        priceLabel.textColor = UIColor.blueColor()
        priceLabel.text = "$" + selectedProduct.price
        
        descriptionLabel.font = UIFont(name: MegaTheme.fontName, size: 13)
        descriptionLabel.textColor = UIColor(white: 0.5, alpha: 1.0)
        descriptionLabel.text = selectedProduct.description
        
        orderButton.titleLabel?.font = UIFont(name: MegaTheme.boldFontName, size: 18)
        orderButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        orderButton.setTitle("ADD TO CART", forState: .Normal)
        orderButton.backgroundColor = UIColor(red: 0.14, green: 0.71, blue: 0.32, alpha: 1.0)
        orderButton.layer.cornerRadius = 20
        orderButton.layer.borderWidth = 0;
        orderButton.clipsToBounds = true;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //insert a product to ProductInCart
        //here I need to use update
        if let moc = self.managedObjectContext {
            ProductsInCart.updateProductsInCart(moc, product: selectedProduct)
        }
        var cartController = (segue.destinationViewController as! CartViewController)
        cartController.productsInCart = ProductsInCart.fetchProducts(managedObjectContext)
    }
    
    //this is used to control the table cell height
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        } else if indexPath.row == 2 {
            return 140
        }else if indexPath.row == 3 {
            return 70
        }else{
            return 45
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        cell.selectionStyle = .None
    }
    
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.layoutMargins = UIEdgeInsetsZero
    }
}