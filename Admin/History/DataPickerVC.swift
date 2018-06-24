//
//  ViewController.swift
//  Admin
//
//  Created by Macintosh on 2018/6/24.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
class DataPickerVC: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var searchButton: UIButton!
    var dateYear = String()
    var dateMonth = String()
    var dateDay = String()
    var orderListDataKeyArray = [String]()
    var UUid = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let fromDateTime = formatter.date(from: "2018 06 23")
        datePicker.minimumDate = fromDateTime
        datePicker.date = NSDate() as Date
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        searchButton.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        dataPickerFirstRespone()
        // Do any additional setup after loading the view.
    }
    
    func dataPickerFirstRespone(){
        let now = Date()
        let dateFormatterYear = DateFormatter()
        let dateFormatterMonth = DateFormatter()
        let dateFormatterDay = DateFormatter()
        dateFormatterYear.dateFormat = "yyyy"
        dateFormatterMonth.dateFormat = "MM"
        dateFormatterDay.dateFormat = "dd"
        dateYear = dateFormatterYear.string(from: now)
        dateMonth = dateFormatterMonth.string(from: now)
        dateDay = dateFormatterDay.string(from: now)
    }
    
    @objc func handleSearchButton(){
        orderListDataKeyArray.removeAll()
        getDB(dateYear, dateMonth, dateDay)
        tableView.reloadData()
    }
    
    @objc func handleDatePicker(){
        let dateFormatterYear = DateFormatter()
        let dateFormatterMonth = DateFormatter()
        let dateFormatterDay = DateFormatter()
        dateFormatterYear.dateFormat = "yyyy"
        dateFormatterMonth.dateFormat = "MM"
        dateFormatterDay.dateFormat = "dd"
        dateYear = dateFormatterYear.string(from: datePicker.date)
        dateMonth = dateFormatterMonth.string(from: datePicker.date)
        dateDay = dateFormatterDay.string(from: datePicker.date)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryTablePop"{
            let dataPicker = segue.destination as! HistoryTableVC
            dataPicker.dateDay = dateDay
            dataPicker.dateMonth = dateMonth
            dataPicker.dateYear = dateYear
            dataPicker.UUid = UUid
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return orderListDataKeyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath)
        
        let text = orderListDataKeyArray[indexPath.row]
        cell.textLabel?.text =  String(text.suffix(4))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UUid = orderListDataKeyArray[indexPath.row]
        performSegue(withIdentifier: "HistoryTablePop", sender: nil)
    }
    
    
    func getDB(_ year:String ,_ month:String,_ day:String){
       
        let userName = ToDoController.userNameData
        let int_year = "\(year)年"
        let int_month = "\(month)月"
        let int_day = "\(day)日"
        Database.database().reference().child("OrderList").child("\(int_year)").child("\(int_month)").child("\(int_day)").child("served").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for keyId in (snapshot.children.allObjects as! [DataSnapshot]){
                
                
                Database.database().reference().child("OrderList").child("\(int_year)").child("\(int_month)").child("\(int_day)").child("served").child(keyId.key).observeSingleEvent(of: .value, with: { (mysnap) in
                    
                    if(mysnap.hasChild(userName)){
                        self.orderListDataKeyArray.append(keyId.key)
                        self.tableView.reloadData()
                    }
                }) { (error) in
                    print(error)
                }
                
            }
            
            print(self.orderListDataKeyArray)
        }) { (error) in
            print("Error get food detail:",error)
        }
        
    }
    
}
    
    

