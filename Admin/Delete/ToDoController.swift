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

class ToDoController{
    
    var foodName = [String]()
    var foodNameArray = [String]()
    static var userNameData = String()
    static var todosArray:Array<String> = []
    
    
    func getUserInfo(userName: String){
        ToDoController.todosArray.removeAll()
        ToDoController.userNameData = userName
        var orderListDataKeyArray = [String]()
        let calendar = Calendar.current
        let now = Date()
        let year = DateFormatter()
        let month = DateFormatter()
        let date = DateFormatter()
        let time = DateFormatter()
        year.dateFormat = "yyyy年"
        month.dateFormat = "MM月"
        date.dateFormat = "dd日"
        time.dateFormat = "HH:mm:ss"
        let isYear = year.string(from: now)
        let isMonth = month.string(from: now)
        let isDate = date.string(from: now)
        
        //抓key而已，把key丟進orderListArray裡面
        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for keyId in (snapshot.children.allObjects as! [DataSnapshot]){
                Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(keyId.key).observeSingleEvent(of: .value, with: { (mysnap) in
                    
                    if(mysnap.hasChild(userName)){
                        print(keyId.key)
                        orderListDataKeyArray.append(keyId.key)
                        ToDoController.todosArray.append(String(keyId.key))
                    }
                }, withCancel: { (error) in
                    print(error)
                })
            }
            
            for orderList in orderListDataKeyArray {
                ToDoController.todosArray.append(String(orderList))
            }
            
        }) { (error) in
            print("Error get food detail:",error)
        }
    }

    func getFoodName(_ snapshot:DataSnapshot)->[String]{
        for food in snapshot.children.allObjects as! [DataSnapshot]{
            foodName += [food.key]
        }
        return foodName
    }
    
    func addToDo( newToDo:String ){
        let now = Date()
        let year = DateFormatter()
        let month = DateFormatter()
        let date = DateFormatter()
        let time = DateFormatter()
        year.dateFormat = "yyyy年"
        month.dateFormat = "MM月"
        date.dateFormat = "dd日"
        time.dateFormat = "HH:mm:ss"
        let isYear = year.string(from: now)
        let isMonth = month.string(from: now)
        let isDate = date.string(from: now)
        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(ToDoController.userNameData).child("StudentId103590054").setValue(["OrderNumber": "ManagementORDER: " + newToDo])
        ToDoController.todosArray.append( "ManagementORDER:"  + "("+newToDo+")")
    }

    func removeToDo(atIndex:Int,userNameRemove:String) {
        print(ToDoController.userNameData)
        var orderListDataKeyArray = [String]()
        let now = Date()
        let year = DateFormatter()
        let month = DateFormatter()
        let date = DateFormatter()
        let time = DateFormatter()
        year.dateFormat = "yyyy年"
        month.dateFormat = "MM月"
        date.dateFormat = "dd日"
        time.dateFormat = "HH:mm:ss"
        let isYear = year.string(from: now)
        let isMonth = month.string(from: now)
        let isDate =  date.string(from: now)
        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").observeSingleEvent(of: .value, with: { (snapshot) in
            for keyId in (snapshot.children.allObjects as! [DataSnapshot]){
                Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(keyId.key).observeSingleEvent(of: .value, with: { (mysnap) in
                    
                    if(mysnap.hasChild(userNameRemove)){
                        orderListDataKeyArray.append(keyId.key)
                    }
                }, withCancel: { (error) in
                    print(error)
                })
                
            }
            var ref: DatabaseReference!
            ref = Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve")
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
            ref.child(orderListDataKeyArray[atIndex]).child(ToDoController.userNameData).setValue(nil)
                
                let dictionary = snapshot.childSnapshot(forPath: orderListDataKeyArray[atIndex]).childSnapshot(forPath: userNameRemove) as! DataSnapshot
                let key = dictionary.key
                let value = dictionary.value
                print("key = \(key)  value = \(value!)")
                            Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("served").child(orderListDataKeyArray[atIndex]).child(userNameRemove).setValue(value)
            }) { (error) in
                print("Error get food detail:",error)
            }
        })
        ToDoController.todosArray.remove(at: atIndex)
    }
}
