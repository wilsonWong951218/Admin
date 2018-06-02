//
//  ToDoController.swift
//  Admin
//
//  Created by larvataAndroid on 2018/5/22.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ToDoController: NSObject {
    
    static var todosArray:Array<String> = []
    class func getUserInfo(userName: String){
//        guard let userName = profileName.text else { return }
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
       

 Database.database().reference().child("OrderList").child(String(year)).child("5").child("22").child("Unserved").child("Shop2").observeSingleEvent(of: .value, with: { (snapshot) in
    guard let dictionary = snapshot.value as? [String:AnyObject] else { return }
            guard let profileUserName = dictionary["OrderNumber"] as? String else { return }
            //            self.profileName.text = profileUserName
    print("snapshot ~:",snapshot)
    
    if profileUserName != "" && ToDoController.todosArray.isEmpty {
        ToDoController.todosArray.append(profileUserName)
    }else{
    }
    
        
        }) { (error) in
            print("Error get food detail:",error)
        }
    }
    class func addToDo( newToDo:String ){
            //            self.profileName.text = profileUserName
            //            print(snapshot)
            Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("Unserved").child("Shop2").child("StudentId103590054").setValue(["OrderNumber": "ManagementORDER: " + newToDo])
            
            ToDoController.todosArray.append( "ManagementORDER:"  + "("+newToDo+")")
    }
    class func removeToDo(atIndex:Int) {
        Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("Unserved").child("Shop2").child("StudentId103590054").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            guard let profileUserName = dictionary["OrderNumber"] as? String else { return }
            //            self.profileName.text = profileUserName
//            print(snapshot)
           Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("Unserved").child("Shop2").child("StudentId103590054").setValue(nil)
            Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("served").child("Shop2").child("StudentId103590054").setValue(["OrderNumber": profileUserName])
           
            
        }) { (error) in
            print("Error get food detail:",error)
        }
//        } Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("served").child("Shop1").child("StudentId103590054").setValue(nil)
//        Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("Unserved").child("Shop1").child("StudentId103590054").setValue(nil)
        

        ToDoController.todosArray.remove(at: atIndex)
        
    }
}
