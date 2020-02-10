//
//  WatchListCell.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 07/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import UIKit
//delegate to remove item from wish list
protocol removedItemFromWatchListDelegate {
     func removeItemFromWatchList(atIndexPath : IndexPath)
}

//to populate data on wish list row item
class WatchListCell: UITableViewCell {
    var indexPath:IndexPath?
       var delegate : removedItemFromWatchListDelegate?

    @IBAction func removeItemFromWatchList(_ sender: Any) {
        self.delegate?.removeItemFromWatchList(atIndexPath: indexPath!)
    }
    
    @IBOutlet weak var watchListProductName: UILabel!
    @IBOutlet weak var watchListProductCategory: UILabel!
    @IBOutlet weak var watchListProductPrice: UILabel!
    @IBOutlet weak var watchListProductOldPrice: UILabel!
    @IBOutlet weak var watchListProcductStock: UILabel!
    
    func setdata(productModel : ProductModelObject){
        watchListProductName.text = productModel.name
        watchListProductCategory.text = "Category: " + productModel.category
        if productModel.oldPrice == nil {
            watchListProductOldPrice.isHidden = true
            watchListProductPrice.text = "Price: "+productModel.price
        }else{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:productModel.price)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            watchListProductPrice.attributedText = attributeString
            watchListProductOldPrice.isHidden = false
            watchListProductOldPrice.text = "New Price: " + productModel.oldPrice!
        }
        watchListProcductStock.text = "Stock :" + String(productModel.stock)
    }
    
    
}
