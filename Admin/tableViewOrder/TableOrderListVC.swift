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

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibCell = UINib(nibName:"OrderListTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "OrderListTableViewCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        return cell
    }
    
}
