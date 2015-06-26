//
//  ProductsInCart.swift
//  LuckKitchen
//
//  Created by Ping Zhang on 6/17/15.
//  Copyright (c) 2015 Ping Zhang. All rights reserved.
//

import Foundation
import CoreData

class ProductsInCart: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var image: String
    @NSManaged var des: String
    @NSManaged var qty: NSNumber
    @NSManaged var price: String
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, product: Product) -> ProductsInCart {
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("ProductsInCart", inManagedObjectContext: moc) as! ProductsInCart
        newItem.title = product.title
        newItem.image = product.image
        newItem.des = product.description
        newItem.qty = 1
        newItem.price = product.price
        
        return newItem
    }
    
    //fetch results
    class func fetchProducts(managedObjectContext: NSManagedObjectContext?) -> [ProductsInCart]?{
        let fetchRequest = NSFetchRequest(entityName: "ProductsInCart")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [ProductsInCart] {
            return fetchResults
        }
        return nil
    }
    
    class func updateProductsInCart(moc: NSManagedObjectContext?, product: Product) {
        let fetchRequest = NSFetchRequest(entityName: "ProductsInCart")
        let predicate = NSPredicate(format: "title == %@", product.title)
        fetchRequest.predicate = predicate
        if let fetchResults = moc!.executeFetchRequest(fetchRequest, error: nil) as? [ProductsInCart] {
            if fetchResults.count == 0{
                createInManagedObjectContext(moc!, product: product)
            }
            else {
                fetchResults[0].qty = NSNumber(int: fetchResults[0].qty.intValue + 1)
            }
        }
        
    }
    


}
