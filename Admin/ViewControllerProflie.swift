//
//  ViewControllerProflie.swift
//  Admin
//
//  Created by Macintosh on 2018/5/9.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerProflie: UIViewController {
    
   var userName = [String]()
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let profileID = UserDefaults.standard.object(forKey:"proflieID") as! NSArray
//
//        let image = UIImage(data: profileID[0] as! Data)
//        profilePic.setImage(image, for: UIControlState.normal)
//        profilePic.layer.cornerRadius = profilePic.frame.width/2
//        profilePic.layer.masksToBounds = true
//
//        profileName.text = profileID[2] as? String
        getUserInfo()

    }
    
    
    @IBAction func logOutButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func getUserInfo(){
        guard let userName = profileName.text else { return }
//        Database.database().reference().child("ShopManagement").child(userName).observeSingleEvent(of: DataEventType.value) { (Snapshot) in
//                      guard let dictionary = Snapshot.value as? [String:Any] else {return}
//            profileName.text = Database.database().reference().child("ShopManagement").child(userName).
//        }
        Database.database().reference().child("ShopManagement").child("Shop1").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let profileUserName = dictionary["userName"] as? String else { return }
            self.profileName.text = profileUserName
            print(snapshot)
            //var foodNameArray = self.getUserName(snapshot)
//            profileName.text = foodNameArray
//            var foodPriceArray = self.getFoodPrice(snapshot)
//            cell.lbName.text = foodNameArray[indexPath.row]
//            cell.lbPrice.text = "Price:\(foodPriceArray[indexPath.row])"
        }) { (error) in
            print("Error get food detail:",error)
        }
//     profileName.text = Database.database().reference().child("ShopManagement").child(userName).

    }
    func getUserName(_ snapshot:DataSnapshot)->[String]{
        for food in snapshot.children.allObjects as! [DataSnapshot]{
           print("food.key")
            //userName += [food.key]
            
        }
        print(userName)
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
