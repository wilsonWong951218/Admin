//
//  SignUpController.swift
//  Admin
//
//  Created by Macintosh on 2018/5/9.
//  Copyright © 2018年 Mac mini. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
//    var dbReference: DatabaseReference?
    var data = [""] as [Any]
    //Mark -> SignUp information Fill
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addPhotoButton.addTarget(self, action: #selector(handlePlusPhoto), for: .touchUpInside)
        emailText.addTarget(self, action: #selector(buttonEnable), for:.editingChanged)
        passwordText.addTarget(self, action: #selector(buttonEnable), for:.editingChanged)
        userNameText.addTarget(self, action: #selector(buttonEnable), for:.editingChanged)
        let path = NSHomeDirectory()
        print(path)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    //Mark -> Back to Login Page
    @IBAction func backToSignInPage(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Mark -> SignUpButton effect
    @IBOutlet weak var signUpButton: UIButton!{
        didSet{
            signUpButton.isEnabled = false
        }
    }
    
    
    
    @objc func buttonEnable(){
        var dataInform = [""]
        if let isEmailValue = emailText.text?.count,let isUserNameValue = userNameText.text?.count,let isPasswordValue = passwordText.text?.count{
            if isEmailValue > 0 && isUserNameValue > 0 && isPasswordValue > 0 {
                signUpButton.isEnabled = true
                signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
                // UserDefaults.standard.set(data, forKey: "arrayData")
                // UserDefaults.standard.synchronize()
                
            }else{
                signUpButton.isEnabled = false
                signUpButton.backgroundColor =  UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
            }
        }
      
    }
    
    
    
    //Mark -> Photo Choose Button
    @objc func handlePlusPhoto(){
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Library", style: .default) { (action) in
            self.handlePlusPhotoLibrary()
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action3 = UIAlertAction(title: "Camera", style: .default) {(_)in
            self.cameraPlusPhoto()
        }
        action2.setValue(UIColor.red, forKey: "titleTextColor")
        sheet.addAction(action1)
        sheet.addAction(action2)
        sheet.addAction(action3)
        present(sheet, animated: true, completion: nil)
        
    }
    
    func handlePlusPhotoLibrary(){
        let imagePickUpControl = UIImagePickerController()
        imagePickUpControl.delegate = self
        imagePickUpControl.sourceType = .photoLibrary
        imagePickUpControl.allowsEditing = true
        present(imagePickUpControl, animated: true, completion: nil)
    }
    
    func cameraPlusPhoto(){
        let cameraPickUpControl = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            cameraPickUpControl.delegate = self
            cameraPickUpControl.sourceType = UIImagePickerControllerSourceType.camera
            cameraPickUpControl.cameraCaptureMode = .photo
            cameraPickUpControl.modalPresentationStyle = .fullScreen
            present(cameraPickUpControl, animated: true, completion: nil)
        }else{
            let alertVC = UIAlertController(
                title: "No Camera",
                message: "Sorry, this device has no camera",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            alertVC.addAction(okAction)
            present(
                alertVC,
                animated: true,
                completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let editImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            addPhotoButton.setImage(editImage.withRenderingMode(.alwaysOriginal), for:.normal)
            let imageData = UIImageJPEGRepresentation(editImage, 100)
            data = [imageData as! Data]
        }else if let orignalImage = info["UIImagePickerControllerOriginalImage"]as?UIImage{
            
            addPhotoButton.setImage(orignalImage.withRenderingMode(.alwaysOriginal), for:.normal)
//            guard let imageData = UIImageJPEGRepresentation(orignalImage, 100) else{return}
//            guard let imageString = String(data: imageData, encoding: .utf8) else{return}
//            data = [imageString]
        }
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width/2
        addPhotoButton.layer.masksToBounds = true
        
        
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpSuccese(_ sender: UIButton) {
        if signUpButton.isEnabled{
//            dbReference = Database.database().reference()
//            dbReference?.child("name").childByAutoId().setValue(userNameText.text!)
//            dbReference?.child("password").childByAutoId().setValue(passwordText.text!)
//            dbReference?.child("email").childByAutoId().setValue(emailText.text!)
            
            performSegue(withIdentifier: "showProfile", sender: nil)
            data += [userNameText.text!,passwordText.text!,emailText.text!]
            UserDefaults.standard.set(data, forKey: "proflieID")
        }
        
    }
    func handleTextInputChange(){
        let isEmailValid = emailText.text?.count ?? 0 > 0
        
    }
   @objc func handleSignUp(){
    guard let userEmail = emailText.text, userEmail.count > 0
        else { return }
    guard let userName = userNameText.text, userName.count > 0
        else { return }
    guard let userPassword = passwordText.text, userPassword.count > 0
        else { return }
    
        Auth.auth().createUser(withEmail: userEmail, password: userPassword, completion: { (User, error) in
            if let err = error {
                print("Failed:", err)
                return
            }
            guard let image = self.addPhotoButton.imageView?.image else { return }
            guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else { return }
            
            let filename = NSUUID().uuidString
            Storage.storage().reference().child("profile_image").child(filename).putData(uploadData, metadata: nil, completion: { (metadata, err) in
                if let err = err {
                    print("Failed to upload profile image: ", err)
                    return // return if it fails
                }
                
                Storage.storage().reference().child("profile_image").downloadURL(completion: { (url, error) in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    print("Sucessfully uploaded profile image", profileImageUrl)
                    
                    guard let uid = User?.user.uid else { return }
                    let userNameValue = ["userName": userName,"ProfileImageURL": profileImageUrl,"UserEmail": userEmail,"UserPassword": userPassword]
//                    let userEmailValue = ["userName": userEmail]
//                    let userPasswordValue = ["userName": userPassword]
//
                    
                    let values = [uid: userNameValue]
                    print("sucess111:",User?.user.uid ?? "")
                    
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                        if let err = err{
                            print("", err)
                            return
                        }
                        print("sucess save db!!!!!!!")
                    })

                })
                
            })
            
            })
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
