//
//  ShopViewController.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/12/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//



import Foundation
import UIKit
import CoreData

class ShopViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView : UICollectionView!
    @IBOutlet var layout : UICollectionViewFlowLayout!
    
    let cellHeight : CGFloat = 200
    var products : [Product]!
    var selectedProduct: Product!
    //shopping cart
    //here I add a segue from ShopViewController to CartViewController called shopToCart
    //then, in the rightBarButtonItem, I want this segue, so I just performSeguewith..
    //and what's more, if I need to carry some information to next viewController, I can simly override
    //prepareForSegue to send the info
    func showCartView(){
        //presentViewController(CartViewController(), animated: false, completion: nil)
        //showViewController(CartViewController(), sender: self)
        performSegueWithIdentifier("shopToCart", sender: self)
    }
    
    func loadProducts() -> [Product] {
        //this part is used to demo products array, these information shuold be returned by the server
        let product1 = Product(title: "Espirit Shirt", price: "45.2", image: "product-1")
        let product2 = Product(title: "Chaplin Memo Shirt", price: "45.4", image: "product-2")
        let product3 = Product(title: "London/ NY Shirt", price: "35.6", image: "product-3")
        let product4 = Product(title: "Retro Grey", price: "65", image: "product-4")
        let product5 = Product(title: "Hadncrafted Tee", price: "25.7", image: "product-5")
        let product6 = Product(title: "Denim Rollup Shirt", price: "55", image: "product-6")
        return [product1, product2, product3, product4, product5, product6]
    }
    
    //core data
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        //these can also be done in storyboard
        collectionView.delegate = self
        collectionView.dataSource = self
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cellWidth = calcCellWidth(self.view.frame.size)
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        
        //shopping cart
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "cart"), style: .Plain, target: self, action: Selector("showCartView"))
        navigationItem.rightBarButtonItem = rightBarItem
        //got to ecommerceboard
        let leftBarItem = UIBarButtonItem(title: "Main Menu", style: .Plain, target: self, action: Selector("showMainMenu"))
        navigationItem.leftBarButtonItem = leftBarItem
        
        title = "Dishes"
        products = loadProducts()
        
        //try
//        let userEmail = NSUserDefaults.standardUserDefaults()
//        if let email = userEmail.stringForKey("userEmail") {
//            println(email)
//        }
    }
    
    func showMainMenu() {
        performSegueWithIdentifier("shopToE", sender: self)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        //here mod is really important, if user scroll the view, the indexPath.row will simple increase, it may be larger than products.count, so that we need to use mod
        //I see because the next function, didn't return products.count instead, it returns any number
        let index = indexPath.row % products.count
        let product = products[index]
        cell.imageView.image = UIImage(named: product.image)
        cell.titleLabel.text = product.title
        cell.priceLabel.text = product.price
        return cell
    }
    
    //display the number of cells
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if products == nil {//for safety
            return 0
        }
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ProductCell
        cell.setCellSelected(true)
        //the following line should below above line
        selectedProduct = products[indexPath.row]
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! ProductCell
        cell.setCellSelected(false)
    }
    
    //this will pass selectedProduct to ProductDetailViewController
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "shopToProductDetail" {
            var productDetailController = (segue.destinationViewController as! ProductDetailViewController)
            productDetailController.selectedProduct = selectedProduct
        }//this else is a trial
        else if segue.identifier == "shopToCart" {
            //now fetch data
            var productsInCart = ProductsInCart.fetchProducts(managedObjectContext)
            var cartController = (segue.destinationViewController as! CartViewController)
            cartController.productsInCart = productsInCart
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var headerView : UICollectionReusableView!
        if kind == "UICollectionElementKindSectionHeader"{
            headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ShopHeaderView", forIndexPath: indexPath) as? UICollectionReusableView
            
            let headerTitleLabel = headerView.viewWithTag(1) as! UILabel
            headerTitleLabel.font = UIFont(name: MegaTheme.fontName, size: 14)
            headerTitleLabel.textColor = UIColor(white: 0.4, alpha: 1.0)
            
            headerTitleLabel.text = "NEW ARRIVALS"
            
        }
        return headerView
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        var cellWidth = calcCellWidth(size)
        layout.itemSize = CGSizeMake(cellWidth, 200)
    }
    
    func calcCellWidth(size: CGSize) -> CGFloat {
        let transitionToWide = size.width > size.height
        var cellWidth = size.width / 2
        
        if transitionToWide {
            cellWidth = size.width / 3
        }
        return cellWidth
    }
}

//.......

class Product {
    var title : String!
    var image : String!
    var price : String!
    var description: String!
    var quanity: Int?
    
    init(title: String, price : String, image: String){
        self.title = title
        self.price = price
        self.image = image
        quanity = 1
        description = "delicious food with great price delicious food with great price delicious food with great price delicious food with great price delicious food with great price delicious food with great price"
    }
}

