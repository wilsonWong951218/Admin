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
    
    @IBOutlet weak var logOutButton: UIButton!
    var idCount = Int()
    let VC = ToDoController()
    var ShopName = String()
    var ShopManage = "ShopManagement"
    var UUIDorder = String()
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: UIButton!
    //    @IBOutlet weak var orderItem: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
        //        let image = UIImage(data: profileID[0] as! Data)
        //        profilePic.setImage(image, for: UIControlState.normal)
        //        profilePic.layer.cornerRadius = profilePic.frame.width/2
        //        profilePic.layer.masksToBounds = true
        
        //        getUserInfo()
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
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
        idCount = ToDoController.todosArray.count
        print(idCount)
        getUserInfo()
        
        return ToDoController.todosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let text = ToDoController.todosArray[indexPath.row] as String
        cell.textLabel?.text = String(text.suffix(5))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       UUIDorder = ToDoController.todosArray[indexPath.row]
        self.performSegue(withIdentifier: "TableOrderListVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            VC.removeToDo(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    @objc func logOut() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        dismiss(animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getUserInfo(){
        let profileID = UserDefaults.standard.object(forKey:"ID") as! NSDictionary
        ShopName = profileID["Username"] as! String
        Database.database().reference().child("ShopManagement").child(ShopName).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let profileUserName = dictionary["userName"] as? String else { return }
            self.profileName.text = "profileUserName"
            print("try")
            self.VC.getUserInfo(userName: self.ShopName)
            if self.idCount == 0{
                self.tableView.reloadData()
            }
            
        }) { (error) in
            print("Error get food detail:",error)
        }
        
    }
    
    
    
}
