//
//  ThirdViewController.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 06/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import UIKit


//class used to populate data in cart list screen and also removing any item from cart list
//total amount calculated on basis of price of items added in cart list
class ThirdViewController: UIViewController {
var cartList: [ProductModelObject] = []
    
     //cart list table which consist list of wish list data
    @IBOutlet weak var cartTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        cartTableView.delegate = self
        cartTableView.dataSource = self
    }
    
    //will display the cart list on tableview
    //list is being fetched from database file of realm
    override func viewWillAppear(_ animated: Bool) {
        cartList = DbHandler.init().cartList()
        cartTableView.reloadData()
    }
}

//for tableview in cart list
extension ThirdViewController: UITableViewDataSource,UITableViewDelegate,removedItemDelegate{
    //will remove item from cart list and will save same in productmodelobject DB file and on removing an alert will displayed to user
    //network call also added to remove item from server cart
    func removeClicked(atIndexPath: IndexPath) {
        ApiHandler.init().fetchCartItemAndDelete(productModelObject: cartList[atIndexPath.row]){
            data in
            self.cartList = data
            self.cartTableView.reloadData()
        }
        let alert = UIAlertController(title: "Alert", message: "Item Removed or quantity reduced from cart list", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //table view method to display number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    //added delegate for remove from cart list button
    //will display each cell in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productModel = cartList[indexPath.row]
        //print("table ==== \(productModel)")
        let cartCell = tableView.dequeueReusableCell(withIdentifier: "CartCellRow") as! CartCell
        cartCell.setdata(productModel: productModel)
        cartCell.delegate = self
        cartCell.indexPath = indexPath
        return cartCell
    }
    
    //for total amount displayed in footer section of cart
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var totalCartAmount:Double  =  0.0
        //for total amount calculations
        if cartList.count > 1{
        for counter in 0 ... (cartList.count-1) {
            totalCartAmount = (totalCartAmount + Double(cartList[counter].price)!)
        }
        }
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        let explanationLabel = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.size.width - 20, height: 80))
        explanationLabel.textColor = UIColor.darkGray
        explanationLabel.numberOfLines = 0
        explanationLabel.text = "Total Amount : $" + String(totalCartAmount)
        footerView.addSubview(explanationLabel as? UIView ?? UIView())
        return footerView
    }
    
    //for height of footer content
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
}
