//
//  SecondViewController.swift
//  TabBarDemo
//
//  Created by Jiju Induchoodan on 06/02/20.
//  Copyright © 2020 Jiju Induchoodan. All rights reserved.
//

import UIKit

//class used to populate data in wish list screen and also removing any item from wish list
class SecondViewController: UIViewController {

    var watchList: [ProductModelObject] = []
     //wish list table which consist list of wish list data
    @IBOutlet weak var watchListTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        watchListTable.delegate = self
        watchListTable.dataSource = self
    }
    
    //will display the wish list on tableview
    //list is being fetched from database file of realm
    override func viewWillAppear(_ animated: Bool) {
        watchList = DbHandler.init().watchList()
        watchListTable.reloadData()
    }
}

//for tableview in wish list
extension SecondViewController: UITableViewDataSource,UITableViewDelegate,removedItemFromWatchListDelegate{
    
    //will remove item from wish list and will save same in productmodelobject DB file and on removing an alert will displayed to user
    func removeItemFromWatchList(atIndexPath: IndexPath) {
        watchList = DbHandler.init().removeFromWatchList(productModelObject: watchList[atIndexPath.row])
        let alert = UIAlertController(title: "Alert", message: "Item Removed from Wishlist", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
           watchListTable.reloadData()
    }
    
    //table view method to display number of cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchList.count
    }
    
    //added delegate for remove from wish list button
      //will display each cell in table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productModel = watchList[indexPath.row]
        //print("table ==== \(productModel)")
        let watchListCell = tableView.dequeueReusableCell(withIdentifier: "WatchListCellRow") as! WatchListCell
        watchListCell.setdata(productModel: productModel)
        watchListCell.delegate = self
        watchListCell.indexPath = indexPath
        return watchListCell
    }
}
