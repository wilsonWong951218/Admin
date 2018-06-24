//
//  tabBarViewController.swift
//  Admin
//
//  Created by Macintosh on 2018/6/24.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit

class tabBarViewController: UITabBarController {
    var id = String()
    
    @IBOutlet weak var tabber: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewProfile = self.viewControllers![0] as! ViewControllerProflie
        viewProfile.loginFirst = id
        tabber.barTintColor = #colorLiteral(red: 0.137254902, green: 0.1725490196, blue: 0.2392156863, alpha: 1)
        tabber.tintColor = UIColor.black
        // Do any additional setup after loading the view.
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
