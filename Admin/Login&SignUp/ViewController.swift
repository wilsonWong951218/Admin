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
    
    
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var errorLabel: UITextView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordText: UITextField!
    
    let VC = ToDoController()

    override func viewDidLoad() {
        super.viewDidLoad()
        //        VC.userNameData = userNameText.text!
        userNameText.addTarget(self, action: #selector(handleTextFill), for: .editingChanged)
        passwordText.addTarget(self, action: #selector(handleTextFill), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(getDBvalue), for: UIControlEvents.touchUpInside)
        loginButton.layer.cornerRadius = 2
        setLayout()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        userNameText.becomeFirstResponder()
        passwordText.becomeFirstResponder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userNameText.resignFirstResponder()
        passwordText.resignFirstResponder()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "id"{
            let tableOrderListVC = segue.destination as! tabBarViewController
            tableOrderListVC.id = "yes"
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
                
            }else{ print("Login False") }

        }) { (Error) in
            print("error",Error)
        }
        ToDoController.todosArray.removeAll()
    }
    
    @objc func handleTextFill(){
        if let isEmailFill = userNameText.text ,let isPasswordFill = passwordText.text{
            if isEmailFill.count > 0 && isPasswordFill.count > 0 {
                loginButton.isEnabled = true
                loginButton.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            }else{
                loginButton.isEnabled = false
                loginButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            }
        }
    }
    
    func setLayout(){
        logo.layer.shadowOpacity = 0.5
        userNameText.layer.shadowOpacity = 0.5
        passwordText.layer.shadowOpacity = 0.5
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.cornerRadius = 11
    }
}

