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
    
   
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profilePic: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let profileID = UserDefaults.standard.object(forKey:"proflieID") as! NSArray
        
        let image = UIImage(data: profileID[0] as! Data)
        profilePic.setImage(image, for: UIControlState.normal)
        profilePic.layer.cornerRadius = profilePic.frame.width/2
        profilePic.layer.masksToBounds = true
        
        profileName.text = profileID[2] as? String

    }
    
    
    @IBAction func logOutButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
