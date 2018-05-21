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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(getDBvalue), for: UIControlEvents.touchUpInside)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func getDBvalue(){
        guard let userText = userNameText.text else { return }
        guard let passwordText = passwordText.text else {return}
        
        Database.database().reference().child("ShopManagement").child(userText).observeSingleEvent(of: DataEventType.value, with: { (Snapshot) in
        
            guard let dictionary = Snapshot.value as? [String:Any] else {return}
            guard let userPassWordText = dictionary["PassWord"] as? String else {return}
            
            if userPassWordText == passwordText{
                print("Login Succese")
                self.performSegue(withIdentifier: "loginSuccess", sender: nil)
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

