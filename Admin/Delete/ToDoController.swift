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
        ToDoController.userNameData = userName
        //        print(userNameData + "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")
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
            
            //    snapshot.childSnapshot(forPath: "key").childSnapshot(forPath: "Shop1") Shop1抓店名字
            
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
            
            print("snapshot ~:",snapshot)
            for keyIndex in orderListDataKeyArray.indices {
                
                Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(orderListDataKeyArray[keyIndex]).observeSingleEvent(of: .value, with: { (mysnap) in
                    
                    if mysnap.hasChild(userName) {
                        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(orderListDataKeyArray[keyIndex]).child(userName).observeSingleEvent(of: .value, with: { (snap) in
//                            let valueMilo = snap.value as! [String:Any]
//                            //抓shop底下的food名字為key
//                            for food in snap.children.allObjects as! [DataSnapshot]{
//                                print(food.key)
//                                ToDoController.todosArray.append(food.key)
//
//
//                            }
//                            print(valueMilo)
                        }, withCancel: { (error) in
                            print(error)
                        })
                        
                    }
                }, withCancel: { (error) in
                    print(error)
                })
                
                
            }
            
        }) { (error) in
            print("Error get food detail:",error)
        }
    }
    
    
    func database(){
        
    }
    
    
    func getFoodName(_ snapshot:DataSnapshot)->[String]{
        for food in snapshot.children.allObjects as! [DataSnapshot]{
            foodName += [food.key]
            
        }
        // print(foodName)
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
        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserved").child(ToDoController.userNameData).child("StudentId103590054").setValue(["OrderNumber": "ManagementORDER: " + newToDo])
        
        ToDoController.todosArray.append( "ManagementORDER:"  + "("+newToDo+")")
    }
    
    
    
    
    
    
    
    func removeToDo(atIndex:Int) {
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
            
            //    snapshot.childSnapshot(forPath: "key").childSnapshot(forPath: "Shop1") Shop1抓店名字
            
            for keyId in (snapshot.children.allObjects as! [DataSnapshot]){
                print(keyId.key)
                orderListDataKeyArray.append(keyId.key)
                
            }
            print("snapshot ~:",snapshot)
            for keyIndex in orderListDataKeyArray.indices {
                
                
                
                Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(orderListDataKeyArray[keyIndex]).child(ToDoController.userNameData).observeSingleEvent(of: .value, with: { (snap) in
                    let valueMilo = snap.value as! [String:Any]
                    //抓shop底下的food名字為key
                    for food in snap.children.allObjects as! [DataSnapshot]{
                        print(food.key)
                        //                        ToDoController.todosArray.append(food.key)
                        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child(orderListDataKeyArray[keyIndex]).child(ToDoController.userNameData).setValue(nil)
                        
                        
                        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("served").child(orderListDataKeyArray[keyIndex]).child(ToDoController.userNameData).updateChildValues(["OrderNumber": "123456"])
                        
                        
                        
                    }
                    print(valueMilo)
                }, withCancel: { (error) in
                    print(error)
                })
            }
            
        }) { (error) in
            print("Error get food detail:",error)
        }
        
        //        Database.database().reference().child("OrderList").child("\(isYear)").child("\(isMonth)").child("\(isDate)").child("Unserve").child("Shop2").child("StudentId103590054").observeSingleEvent(of: .value, with: { (snapshot) in
        //            guard let dictionary = snapshot.value as? [String:Any] else { return }
        //            guard let profileUserName = dictionary["OrderNumber"] as? String else { return }
        //            //            self.profileName.text = profileUserName
        ////            print(snapshot)
        //           Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("Unserved").child("Shop2").child("StudentId103590054").setValue(nil)
        //            Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("served").child("Shop2").child("StudentId103590054").setValue(["OrderNumber": profileUserName])
        //
        //
        //        }) { (error) in
        //            print("Error get food detail:",error)
        //        }
        //        } Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("served").child("Shop1").child("StudentId103590054").setValue(nil)
        //        Database.database().reference().child("OrderList").child("2018").child("5").child("22").child("Unserved").child("Shop1").child("StudentId103590054").setValue(nil)
        
        
        ToDoController.todosArray.remove(at: atIndex)
        
    }
}
