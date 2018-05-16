//
//  ViewControllerProflie.swift
//  Admin
//
//  Created by Macintosh on 2018/5/9.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
class ViewControllerProflie: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    @IBOutlet weak var tableView: UITableView!
    var cellItem = ["Order1","Order2","Order3","Order4","Order5"]
    var cellItem1 = ["Order6","Order7","Order8","Order19"]
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(heandleClose), for: .touchUpInside)
        return button
        
//        let label = UILabel()
//        label.text = "Order Form"
//        label.font = UIFont(name: "Chalkduster", size: 40)
//        label.backgroundColor = UIColor.lightGray
//        return label
    }
    
    @objc func heandleClose(){
         var indexPaths = [IndexPath]()
        for row in cellItem.indices{
            let indexPath = IndexPath(row: row, section: 0)
            indexPaths.append(indexPath)
        }
        cellItem.removeAll()
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellItem.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = cellItem[indexPath.row]
        cell.accessoryType = .disclosureIndicator
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select section:\(indexPath.section)")
        print("select section:\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            cellItem.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
   
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
       tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)

    }
    @objc func refreshList(){
        self.cellItem = cellItem1
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
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
