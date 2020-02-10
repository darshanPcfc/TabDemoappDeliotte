//
//  FirstViewController.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 06/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import UIKit

//for products screen in first tab to fetch and populate data on table
class FirstViewController: UIViewController {
    var productList: [ProductModelObject] = []
    //product table which consist list of all products
    @IBOutlet weak var productListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        productListTable.delegate = self
        productListTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    //this function will fetch data only if data is not present in database and productlistapi returns the list of products if present in api
    //or it will fetch data from database if data does not exist in database
    func fetchData(){
        ApiHandler.init().productListApi(){
            data in
            DbHandler.init().saveProductList(productListResponse: data){
                data in
                self.productList = data
                self.productListTable.reloadData()
            }
        }
    }
}

//for tableview in product list
extension FirstViewController: UITableViewDataSource,UITableViewDelegate,productDelegate{
    
    //will add item to wish list and will save same in productmodelobject DB file and on adding an alert will displayed to user
    func addToWatchList(atIndexPath: IndexPath) {
        DbHandler.init().addToWatchList(productModelObject: productList[atIndexPath.row])
        displayAlertController(message: "Item Added To your Wishlist")
    }
    
    //to display alert message to user
    func displayAlertController(message : String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //will add item to cart list and will save same in productmodelobject DB file and on adding an alert will displayed to user
    //will only add data in cart model if product added to cart message received from server
    func addToCart(atIndexPath: IndexPath) {
        ApiHandler.init().addToCartApi(productModelObject: productList[atIndexPath.row]){
            data in
            if data.contains("Product added to cart"){
                DbHandler.init().addToCart(productModelObject: self.productList[atIndexPath.row])
            }
            self.displayAlertController(message: data)
        }
    }
    
    //table view method to display number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    //added delegate for add to cart and add to wish list button
    //will display each cell in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productModel = productList[indexPath.row]
        let productCell = tableView.dequeueReusableCell(withIdentifier: "ProdCellRow") as! ProductCell
        productCell.setdata(productModel: productModel)
        productCell.delegate = self
        productCell.indexPath = indexPath
        return productCell
    }
}

