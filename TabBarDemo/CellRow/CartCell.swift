//
//  CartCell.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 07/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import UIKit

//delegate to remove item from cart list
protocol removedItemDelegate {
     func removeClicked(atIndexPath : IndexPath)
}

//this class will populate data to cell in cart table of cart screen
class CartCell: UITableViewCell {
    var indexPath:IndexPath?
    var delegate : removedItemDelegate?

    @IBOutlet weak var cartProductQuantity: UILabel!
    @IBOutlet weak var cartProductName: UILabel!
    @IBOutlet weak var cartProductCategory: UILabel!
    @IBOutlet weak var cartProductPrice: UILabel!
    @IBOutlet weak var cartProductOldPrice: UILabel!
    @IBOutlet weak var cartProductStock: UILabel!
    @IBAction func removeClicked(_ sender: Any) {
        self.delegate?.removeClicked(atIndexPath: indexPath!)
    }
    
    func setdata(productModel : ProductModelObject){
        cartProductName.text = productModel.name
        cartProductCategory.text = "Category: " + productModel.category
        if productModel.oldPrice == nil {
            cartProductOldPrice.isHidden = true
            cartProductPrice.text = "Price: "+productModel.price
        }else{
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:productModel.price)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            
            cartProductPrice.attributedText = attributeString
            cartProductOldPrice.isHidden = false
            cartProductOldPrice.text = "New Price: " + productModel.oldPrice!
        }
        cartProductStock.text = "Stock :" + String(productModel.stock)
        if productModel.cartCounter != nil{
            if productModel.cartCounter != "0"{
                cartProductQuantity.isHidden = false
                cartProductQuantity.text = "Quantity: " + productModel.cartCounter!
            }else{
                cartProductQuantity.isHidden = true
            }
        }else{
            cartProductQuantity.isHidden = true
        }
    }
}
