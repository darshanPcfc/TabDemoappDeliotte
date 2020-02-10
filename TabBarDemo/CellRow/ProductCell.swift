//
//  ProductCell.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 07/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import UIKit

//delegate to add item to wish list and to add item to cart list
protocol productDelegate {
     func addToCart(atIndexPath : IndexPath)
    func addToWatchList(atIndexPath: IndexPath)
}

//this class will populate data to individual cell of product table
class ProductCell: UITableViewCell {
    var indexPath:IndexPath?
    var delegate : productDelegate?
    
    @IBAction func addToWatchList(_ sender: Any) {
        self.delegate?.addToWatchList(atIndexPath: indexPath!)
    }
    @IBAction func addToCart(_ sender: Any) {
        self.delegate?.addToCart(atIndexPath: indexPath!)
    }

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productOldPrice: UILabel!
    @IBOutlet weak var productStock: UILabel!
    
    func setdata(productModel : ProductModelObject){
        productName.text = productModel.name
        productCategory.text = "Category: " + productModel.category
        if productModel.oldPrice == nil {
            productOldPrice.isHidden = true
            productPrice.text = "Price: "+productModel.price
        }else{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:productModel.price)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            productPrice.attributedText = attributeString
            productOldPrice.isHidden = false
            productOldPrice.text = "New Price: " + productModel.oldPrice!
        }
        productStock.text = "Stock :" + String(productModel.stock)
    }
}
