//
//  ViewControllerProflie.swift
//  Admin
//
//  Created by Macintosh on 2018/5/9.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewControllerProflie: UIViewController, UITableViewDataSource, UITableViewDelegate ,UITabBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var LogOutButton: UIButton!
    var idCount = Int()
    let VC = ToDoController()
    var loginFirst = String()
    var ShopName = String()
    var ShopManage = "ShopManagement"
    var UUIDorder = String()
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: UIButton!
    var refreshControl = UIRefreshControl()
    //    @IBOutlet weak var orderItem: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action:#selector(refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        getUserInfo()
        refreshTableViewInTime()
        LogOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        LogOutButton.layer.cornerRadius = 2.5
        LogOutButton.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    
    @objc func refreshTable(){
        viewDidLoad()
    }
    
   func refreshTableViewInTime(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TableOrderListVC"{
            let tableOrderListVC = segue.destination as! TableOrderListVC
            tableOrderListVC.UUIDorder = UUIDorder
            tableOrderListVC.shopName = ShopName
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoController.todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = ToDoController.todosArray[indexPath.row] as String

        cell.textLabel?.text = String(text.suffix(4))
       // cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       UUIDorder = ToDoController.todosArray[indexPath.row]
        self.performSegue(withIdentifier: "TableOrderListVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            VC.removeToDo(atIndex: indexPath.row,userNameRemove: ShopName)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @objc func logOut() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: "BackLogInPage", sender: nil)
    }
    
    func getUserInfo(){

        let profileID = UserDefaults.standard.object(forKey:"ID") as! NSDictionary
        ShopName = profileID["Username"] as! String
        Database.database().reference().child("ShopManagement").child(ShopName).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let profileUserName = dictionary["userName"] as? String else { return }
            self.profileName.text = profileUserName
            print("try")
            self.VC.getUserInfo(userName: self.ShopName)
            self.tableView.reloadData()
        }) { (error) in
            print("Error get food detail:",error)
        }

        
    }
    
    
    
    
}
