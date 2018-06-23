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
    
    @IBOutlet weak var errorLabel: UITextView!
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
        userNameText.addTarget(self, action: #selector(handleTextFill), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(handleTextFill), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(getDBvalue), for: UIControlEvents.touchUpInside)
        loginButton.layer.cornerRadius = 2
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewControllerProflie"{
            let tableOrderListVC = segue.destination as! ViewControllerProflie
            tableOrderListVC.loginFirst = "yes"
        }
    }

    @objc func getDBvalue(){
        if(userNameText.text == "" || passwordText.text == ""){ return }
        
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
    
    
    
    @objc func handleTextFill(){
        if let isEmailFill = userNameText.text ,let isPasswordFill = passwordText.text{
            if isEmailFill.count > 0 && isPasswordFill.count > 0 {
                loginButton.isEnabled = true
                loginButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            }else{
                loginButton.isEnabled = false
                loginButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
        }
    }
    
}

