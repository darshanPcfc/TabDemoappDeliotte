//
//  ProductModel.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 07/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import Foundation
import RealmSwift

//common model object for real me table and decoding json response from product list api
//primary key is id so it helps in avoiding duplicate entries in database
//isInWatchlist is to save wish list object in database
//isInCart is to save cart object in database
//cartCounter is added to for quantity added for multiple items added in cart
class ProductModelObject: Object,Decodable {
    
    @objc dynamic var id =  0
    @objc dynamic var name = "122"
    @objc dynamic var category =  "122"
    @objc dynamic var price =  "122"
    @objc dynamic var oldPrice:String? = "122"
    @objc dynamic var stock = 2
    @objc dynamic var isInWatchlist:String? = "false"
    @objc dynamic var isInCart: String? = "false"
    @objc dynamic var cartCounter: String? = "0"
     
 override static func primaryKey() -> String? {
        return "id"
    }
}
