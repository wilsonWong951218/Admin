//
//  HistoryTableVC.swift
//  Admin
//
//  Created by Macintosh on 2018/6/24.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
class HistoryTableVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var historyTable: UITableView!
    var dateYear = String()
    var dateMonth = String()
    var dateDay = String()
    var UUid = String()
    var foodName = [String]()
    var foodCount = [String]()
    var foodPrice = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName:"HistoryTableViewCell", bundle: nil)
        historyTable.register(nibCell, forCellReuseIdentifier: "HistoryTableViewCell")
        getDB()
        backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        backView.layer.cornerRadius = 10
    }

    @objc func handleBackButton(){
        dismiss(animated: true, completion: nil)
    }
    
    func getDB(){
        let userName = ToDoController.userNameData
        let int_year = "\(dateYear)年"
        let int_month = "\(dateMonth)月"
        let int_day = "\(dateDay)日"
        Database.database().reference().child("OrderList").child("\(int_year)").child("\(int_month)").child("\(int_day)").child("served").child("\(UUid)").child("Shop2").observeSingleEvent(of: .value, with: { (dataSnap) in
       
            let dictionary = dataSnap.value as! [String:Any]
            for food in dataSnap.children.allObjects as! [DataSnapshot]{
                
                let foodDetail = dictionary["\(food.key)"] as! [String:Any]
                let foodDetailCount = foodDetail["Count"] as! String
                let foodDetailPrice = foodDetail["Price"] as! String
                self.foodName.append(food.key)
                self.foodCount.append(foodDetailCount)
                self.foodPrice.append(foodDetailPrice)
            }
            self.historyTable.reloadData()
            
        }) { (error) in
            print("get table order list:",error)
        }
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodName.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTable.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.lbFood.text = foodName[indexPath.row]
        cell.lbOrder.text = foodPrice[indexPath.row]
        cell.lbPrice.text = foodCount[indexPath.row]
        return cell
    }
    
    
    
}
