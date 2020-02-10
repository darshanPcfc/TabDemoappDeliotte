//
//  DbHandler.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 08/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import Foundation
import RealmSwift

//this class will handle all DB related operations
class DbHandler{
    //realme object for internal database read and write operation
      let realm = try! Realm()
    
    //saving the product list after api call
    func saveProductList(productListResponse:[ProductModelObject],completionhandler:@escaping ([ProductModelObject]) -> ()){
        try! self.realm.write {
            self.realm.add(productListResponse, update: .modified)
            completionhandler(self.productLis())
        }
    }
    
    //for fetching product list from database this method will return a list of ProductObject Model which contains whole product list
    func productLis() -> [ProductModelObject]{
        return Array(realm.objects(ProductModelObject.self))
    }
    
    //this will return the wish list to populate on wishlist
    func watchList()-> [ProductModelObject]{
        return Array(realm.objects(ProductModelObject.self).filter("isInWatchlist = 'true'"))
    }
    
    //this will return cart list which will populate on cart screen
    func cartList()-> [ProductModelObject]{
        return Array(realm.objects(ProductModelObject.self).filter("isInCart = 'true'"))
    }
    
    //this will add an item to wish list
    func addToWatchList(productModelObject : ProductModelObject){
        try! realm.write {
            productModelObject.isInWatchlist = "true"
        }
    }
    
    //this will add an item to cart if multiple entries then it will increase the quantity
    func addToCart(productModelObject : ProductModelObject){
        if productModelObject.cartCounter == nil {
            try! realm.write {
                productModelObject.isInCart = "true"
                productModelObject.cartCounter = "1"
            }
        }else {
            var increaseCartQuantity:Int = Int(productModelObject.cartCounter!)!
            increaseCartQuantity += 1
            //var
            try! realm.write {
                productModelObject.isInCart = "true"
                productModelObject.cartCounter = String(increaseCartQuantity)
            }
        }
    }
    
    //this function will remove an item from wish list
    func removeFromWatchList(productModelObject : ProductModelObject)->[ProductModelObject]{
        try! realm.write {
            productModelObject.isInWatchlist = "false"
        }
        return watchList()
    }
    
    //this function will decrement the quantity in watch list and will remove the entry from cart list if quantity is 0
    func removeFromCart(productModelObject : ProductModelObject)->[ProductModelObject]{
        var decreaseQuantity:Int = Int(productModelObject.cartCounter!)!
        decreaseQuantity -= 1
        try! realm.write {
            if decreaseQuantity == 0{
                productModelObject.isInCart = "false"
            }
            else{
                productModelObject.cartCounter = String(decreaseQuantity)
            }
        }
        return cartList()
    }
}
