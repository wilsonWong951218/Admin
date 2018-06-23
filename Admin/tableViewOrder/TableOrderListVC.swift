//
//  ViewController.swift
//  Admin
//
//  Created by Macintosh on 2018/6/23.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
class TableOrderListVC: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var UUIDorder = String()
    var shopName = String()
    var foodName = [String]()
    var foodCount = [String]()
    var foodPrice = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName:"OrderListTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "OrderListTableViewCell")
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
       getDB()
        print(UUIDorder)
        
        
    }
    
    @objc func handleBackButton(){
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        cell.lbFood.text = foodName[indexPath.row]
        cell.lbPrice.text = foodPrice[indexPath.row]
        cell.lbOrdered.text = foodCount[indexPath.row]
        return cell
    }
    
    
    func getDB(){
        let now = Date()
        let year = DateFormatter()
        let month = DateFormatter()
        let date = DateFormatter()
        let time = DateFormatter()
        year.dateFormat = "yyyy年"
        month.dateFormat = "MM月"
        date.dateFormat = "dd日"
        time.dateFormat = "HH:mm:ss"
        let isYear = year.string(from: now)
        let isMonth = month.string(from: now)
        let isDate = date.string(from: now)
        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child("\(UUIDorder)").child("\(shopName)").observeSingleEvent(of: .value, with: { (dataSnap) in
            let dictionary = dataSnap.value as! [String:Any]
            for food in dataSnap.children.allObjects as! [DataSnapshot]{
               
                let foodDetail = dictionary["\(food.key)"] as! [String:Any]
                let foodDetailCount = foodDetail["Count"] as! String
                let foodDetailPrice = foodDetail["Price"] as! String
                self.foodName.append(food.key)
                self.foodCount.append(foodDetailCount)
                self.foodPrice.append(foodDetailPrice)
            }
            self.tableView.reloadData()
            
        }) { (error) in
            print("get table order list:",error)
        }
    }
}
