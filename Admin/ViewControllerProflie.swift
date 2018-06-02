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

class ViewControllerProflie: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var userName = [String]()
    var ShopName:String?
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: UIButton!
//    @IBOutlet weak var orderItem: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        //guard let userName = profileName.text else { return }

//        ToDoController.getUserInfo(userName: String(userName))
        let profileID = UserDefaults.standard.object(forKey:"proflieID") as! NSArray

        let image = UIImage(data: profileID[0] as! Data)
        profilePic.setImage(image, for: UIControlState.normal)
        profilePic.layer.cornerRadius = profilePic.frame.width/2
        profilePic.layer.masksToBounds = true
//
//        profileName.text = profileID[2] as? String
        getUserInfo()

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
        
        cell.textLabel?.text = ToDoController.todosArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == UITableViewCellEditingStyle.delete {
            ToDoController.removeToDo(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    @IBAction func logOutButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func getUserInfo(){
        guard let userName = profileName.text else { return }

 Database.database().reference().child("ShopManagement").child("Shop2").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let profileUserName = dictionary["userName"] as? String else { return }
            self.profileName.text = profileUserName
            print(snapshot)

        }) { (error) in
            print("Error get food detail:",error)
        }
    }
    func getUserName(_ snapshot:DataSnapshot)->[String]{
        for food in snapshot.children.allObjects as! [DataSnapshot]{
           print("food.key")
            //userName += [food.key]
            
        }
//        print(userName)
        return userName
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
