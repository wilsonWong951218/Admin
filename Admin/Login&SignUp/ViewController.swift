//
//  ViewController.swift
//  Admin
//
//  Created by Mac mini on 2018/5/6.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    let VC = ToDoController()
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let ViewControllerPass = segue.destination as! ViewControllerProflie
    //        if let tezt = self.userNameText.text{
    //            ViewControllerPass.profileName.text = tezt
    //            print("okay" + tezt)
    //        }
    //    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        VC.userNameData = userNameText.text!
        loginButton.addTarget(self, action: #selector(getDBvalue), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let data = segue.destination as! ToDoController
//        data.userNameData = userNameText.text!
    }
    @objc func getDBvalue(){
        guard let userText = userNameText.text else { return }
        guard let passwordText = passwordText.text else {return}
        Database.database().reference().child("ShopManagement").child(userText).observeSingleEvent(of: DataEventType.value, with: { (Snapshot) in
            
            guard let dictionary = Snapshot.value as? [String:Any] else {return}
            guard let userPassWordText = dictionary["PassWord"] as? String else {return}
            
            if userPassWordText == passwordText{
                let dictioneryID = ["Username":userText,"Password":passwordText]
                UserDefaults.standard.set(dictioneryID, forKey: "ID")
                UserDefaults.standard.synchronize()
                print("Login Succese")
                self.performSegue(withIdentifier: "id", sender: nil)
                
                self.VC.getUserInfo(userName: userText)
            }else{
                // MARK: -有小bug（第一次login fail不會print 要等login success後）
                print("Login False")
            }
            //            if userPassword == passwordText{
            //                print("Login Success")
            //            }else{
            //                print("Login False")
            //            }
            
        }) { (Error) in
            print("error",Error)
        }
    }
    
    
    
}

